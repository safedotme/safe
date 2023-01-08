package models

type LocalKeys struct {
	Build EnvType `json:"build"`
	Dev   EnvType `json:"dev"`
}

type EnvType struct {
	Key        string `json:"key"`
	Secret     string `json:"secret"`
	RootDir    string `json:"root_dir"`
	GoogleCred string `json:"google_creds"`
}
