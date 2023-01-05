package models

type ResourceId struct {
	ResourceID string `json:"resourceId"`
}

type StopResponse struct {
	ResourceID string         `json:"resourceId"`
	SID        string         `json:"sid"`
	Response   ServerResponse `json:"serverResponse"`
}

type ServerResponse struct {
	UploadingStatus string     `json:"uploadingStatus"`
	Files           []FileList `json:"fileList"`
}

type FileList struct {
	Filename       string `json:"fileName"`
	SliceStartTime string `json:"sliceStartTime"`
}

type StartResponse struct {
	ResourceID string `json:"resourceId"`
	SID        string `json:"sid"`
}
