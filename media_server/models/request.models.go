package models

type RTCBody struct {
	Role           string `json:"role"`
	TokenType      string `json:"tokenType"`
	UserID         string `json:"uid"`
	AppID          string `json:"appId"`
	ChannelName    string `json:"channelName"`
	AppCertificate string `json:"appCertificate"`
}
