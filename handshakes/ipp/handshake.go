package ipp

import (
	"lzr"
	"net/http"
	"net/http/httputil"
	"strings"
)

// Handshake implements the lzr.Handshake interface
type HandshakeMod struct {
}

func (h *HandshakeMod) GetData(dst string) []byte {

	req, _ := http.NewRequest("POST", "/ipp", nil)
	req.Host = dst
	req.Header.Add("Host", dst)
	req.Header.Set("User-Agent", "Mozilla/5.0 zgrab/0.x")
	req.Header.Set("Accept", "*/*")
	req.Header.Set("Content-Type", "application/ipp")
	req.Header.Set("Accept-Encoding", "gzip")
	data, _ := httputil.DumpRequest(req, false)
	return data
}

func (h *HandshakeMod) Verify(data string) string {

	if strings.Contains(data, "ipp") &&
		strings.Contains(data, "200 OK") {

		if strings.Contains(data, "attributes-charset") ||
			strings.Contains(data, "print") {
			return "ipp"
		}
	}
	return ""

}

func RegisterHandshake() {
	var h HandshakeMod
	lzr.AddHandshake("ipp", &h)
}
