/* Code generated by cmd/cgo; DO NOT EDIT. */

#include <stdlib.h>
#include "_cgo_export.h"

#pragma GCC diagnostic ignored "-Wunknown-pragmas"
#pragma GCC diagnostic ignored "-Wpragmas"
#pragma GCC diagnostic ignored "-Waddress-of-packed-member"
#pragma GCC diagnostic ignored "-Wunknown-warning-option"
#pragma GCC diagnostic ignored "-Wunaligned-access"
extern void crosscall2(void (*fn)(void *), void *, int, size_t);
extern size_t _cgo_wait_runtime_init_done(void);
extern void _cgo_release_context(size_t);

extern char* _cgo_topofstack(void);
#define CGO_NO_SANITIZE_THREAD
#define _cgo_tsan_acquire()
#define _cgo_tsan_release()


#define _cgo_msan_write(addr, sz)

extern void _cgoexp_6a4648ea8767_getActiveWindow(void *);

CGO_NO_SANITIZE_THREAD
char* getActiveWindow()
{
	size_t _cgo_ctxt = _cgo_wait_runtime_init_done();
	typedef struct {
		char* r0;
	} __attribute__((__packed__)) _cgo_argtype;
	static _cgo_argtype _cgo_zero;
	_cgo_argtype _cgo_a = _cgo_zero;
	_cgo_tsan_release();
	crosscall2(_cgoexp_6a4648ea8767_getActiveWindow, &_cgo_a, 8, _cgo_ctxt);
	_cgo_tsan_acquire();
	_cgo_release_context(_cgo_ctxt);
	return _cgo_a.r0;
}
extern void _cgoexp_6a4648ea8767_enforce_binding(void *);

CGO_NO_SANITIZE_THREAD
void enforce_binding()
{
	size_t _cgo_ctxt = _cgo_wait_runtime_init_done();
	typedef struct {
		char unused;
	} __attribute__((__packed__)) _cgo_argtype;
	static _cgo_argtype _cgo_zero;
	_cgo_argtype _cgo_a = _cgo_zero;
	_cgo_tsan_release();
	crosscall2(_cgoexp_6a4648ea8767_enforce_binding, &_cgo_a, 0, _cgo_ctxt);
	_cgo_tsan_acquire();
	_cgo_release_context(_cgo_ctxt);
}

CGO_NO_SANITIZE_THREAD
void _cgo_6a4648ea8767_Cfunc__Cmalloc(void *v) {
	struct {
		unsigned long long p0;
		void *r1;
	} __attribute__((__packed__)) *a = v;
	void *ret;
	_cgo_tsan_acquire();
	ret = malloc(a->p0);
	if (ret == 0 && a->p0 == 0) {
		ret = malloc(1);
	}
	a->r1 = ret;
	_cgo_tsan_release();
}
