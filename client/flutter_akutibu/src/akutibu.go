package main

import "C"

import (
	"bytes"
	"encoding/base64"
	"encoding/json"
	"fmt"
	"image"
	"image/color"
	"image/png"

	"github.com/disintegration/imaging"
	"github.com/fcjr/geticon"
	"github.com/go-vgo/robotgo"
)

//export getActiveWindow
func getActiveWindow() *C.char {

	var imageToBase64 = func(img image.Image) (string, error) {
		buf := new(bytes.Buffer)
		if err := png.Encode(buf, img); err != nil {
			return "", err
		}
		base64Str := base64.StdEncoding.EncodeToString(buf.Bytes())
		return base64Str, nil
	}

	pid := robotgo.GetPid()
	name, err := robotgo.FindName(robotgo.GetPid())
	if err != nil {
		name = "Unknown"
	}
	path, err := robotgo.FindPath(pid)
	if err != nil {
		path = "Unknown"
	}
	iconImage, err := geticon.FromPid(uint32(pid))
	var dstImage128 image.Image
	if err == nil {
		dstImage128 = imaging.Resize(iconImage, 128, 128, imaging.Lanczos)
	} else {
		dstImage128 = imaging.New(128, 128, color.NRGBA{0, 0, 0, 0})
	}
	iconBase64, err := imageToBase64(dstImage128)
	if err != nil {
		iconBase64 = ""
	}
	icon := fmt.Sprintf("data:image/png;base64,%s", iconBase64)
	title := robotgo.GetTitle()

	data, _ := json.Marshal(map[string]any{
		"pid":   pid,
		"name":  name,
		"path":  path,
		"icon":  icon,
		"title": title,
	})

	println(string(data))

	return C.CString(string(data))
}

//export enforce_binding
func enforce_binding() {}

func main() {
}
