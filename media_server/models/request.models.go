package models

// ⬇️ PROCESS
type ProcessBody struct {
	Path              string `json:"path"`
	OutputFilename    string `json:"outputFilename"`
	WatermarkFilename string `json:"watermarkFilename"`
	ThumbnailFilename string `json:"thumbnailFilename"`
	BucketID          string `json:"bucketId"`
}

// ⬇️ RTC
type RTCBody struct {
	Role           string `json:"role"`
	TokenType      string `json:"tokenType"`
	UserID         string `json:"uid"`
	AppID          string `json:"appId"`
	ChannelName    string `json:"channelName"`
	AppCertificate string `json:"appCertificate"`
}

// ⬇️ RID

type RIDBody struct {
	AppID          string `json:"appId"`
	ChannelName    string `json:"channelName"`
	CustomerKey    string `json:"customerKey"`
	CustomerSecret string `json:"customerSecret"`
	RecordingID    string `json:"recordingId"`
}

// ⬇️ START
type StartBody struct {
	AppID          string  `json:"appId"`
	ChannelName    string  `json:"channelName"`
	CustomerKey    string  `json:"customerKey"`
	CustomerSecret string  `json:"customerSecret"`
	ResourceID     string  `json:"resourceId"`
	Token          string  `json:"token"`
	MaxIdleTime    string  `json:"maxIdleTime"`
	Storage        Storage `json:"storage"`
	RecordingID    string  `json:"recordingId"`
	UserID         string  `json:"uid"`
}

type Storage struct {
	BucketID        string `json:"bucketId"`
	BucketAccessKey string `json:"bucketAccessKey"`
	BucketSecretKey string `json:"bucketSecretKey"`
	Dir1            string `json:"dir1"`
	Dir2            string `json:"dir2"`
}

// ⬇️ STOP

type StopBody struct {
	AppID          string `json:"appId"`
	BucketID       string `json:"bucketId"`
	ChannelName    string `json:"channelName"`
	CustomerKey    string `json:"customerKey"`
	CustomerSecret string `json:"customerSecret"`
	ResourceID     string `json:"resourceId"`
	SID            string `json:"sid"`
	RecordingID    string `json:"recordingId"`
}
