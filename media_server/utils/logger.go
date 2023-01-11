package utils

import (
	"net/http"
	"os"
	"strings"
)

func Log(out, incidentId string) {
	var err error
	client := &http.Client{}
	var req *http.Request
	token, ok := os.LookupEnv("LOG_KEY")

	if !ok {
		return
	}

	endpoint := "https://api.logsnag.com/v1/log"

	body := `
	{
		"project": "safe",
		"channel": "error",
		"event": "media_server_failed",
		"description": "<description>",
		"icon": "🚨",
		"tags": {
			"incidentid": "<id>"
		},
		"notify": true
	}
	`

	body = strings.ReplaceAll(body, "<description>", out)
	body = strings.ReplaceAll(body, "<id>", incidentId)

	encoded := strings.NewReader(body)

	if err != nil {
		return
	}

	req, err = http.NewRequest("POST", endpoint, encoded)

	if err != nil {
		return
	}

	req.Header.Add("Authorization", "Bearer "+token)
	req.Header.Add("Content-Type", "application/json")

	// Make Request
	client.Do(req)
}
