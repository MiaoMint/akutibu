package main

import "C"

import (
	"bytes"
	"encoding/base64"
	"encoding/json"
	"fmt"
	"image"
	"image/png"

	"github.com/disintegration/imaging"
	"github.com/fcjr/geticon"
	"github.com/go-vgo/robotgo"
)

// export getActiveWindow
func getActiveWindow() string {

	var imageToBase64 = func(img image.Image) (string, error) {
		buf := new(bytes.Buffer)
		if err := png.Encode(buf, img); err != nil {
			return "", err
		}
		base64Str := base64.StdEncoding.EncodeToString(buf.Bytes())
		return base64Str, nil
	}

	pid := robotgo.GetPid()
	name, _ := robotgo.FindName(robotgo.GetPid())
	path, _ := robotgo.FindPath(pid)
	iconImage, _ := geticon.FromPid(uint32(pid))
	dstImage128 := imaging.Resize(iconImage, 128, 128, imaging.Lanczos)
	iconBase64, _ := imageToBase64(dstImage128)
	icon := fmt.Sprintf("data:image/png;base64,%s", iconBase64)
	title := robotgo.GetTitle()

	data, _ := json.Marshal(map[string]any{
		"pid":   pid,
		"name":  name,
		"path":  path,
		"icon":  icon,
		"title": title,
	})

	return string(data)
}

func main() {
}
