package utils

import (
	"encoding/base64"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"strconv"
	"strings"
	"time"

	"github.com/AgoraIO-Community/go-tokenbuilder/rtctokenbuilder"
)

func ContainsEmpty(ss ...string) bool {
	for _, s := range ss {
		if s == "" {
			return true
		}
	}
	return false
}

func Request(customerKey, customerSecret, endpoint, bodyBase string) (rid []byte, statusCode int, err error) {

	// Concatenate customer key and customer secret and use base64 to encode the concatenated string
	plainCredentials := customerKey + ":" + customerSecret
	base64Credentials := base64.StdEncoding.EncodeToString([]byte(plainCredentials))

	url := "https://api.agora.io/v1/apps/" + endpoint
	method := "POST"

	payload := strings.NewReader(bodyBase)

	client := &http.Client{}
	req, prob := http.NewRequest(method, url, payload)

	if prob != nil {
		fmt.Println(prob)
		return nil, 400, prob
	}
	// Add Authorization header
	req.Header.Add("Authorization", "Basic "+base64Credentials)
	req.Header.Add("Content-Type", "application/json")

	// Send HTTP request
	res, prob := client.Do(req)
	if prob != nil {
		fmt.Println(prob)
		return nil, 400, prob
	}
	defer res.Body.Close()

	body, prob := ioutil.ReadAll(res.Body)

	if prob != nil {
		fmt.Println(prob)
		return nil, res.StatusCode, prob
	}

	return body, res.StatusCode, prob
}

func GetExpireTimestamp(expireTime string) (timestamp uint32, err error) {

	expireTime64, parseErr := strconv.ParseUint(expireTime, 10, 64)

	if parseErr != nil {
		// If string conversion fails return an error
		err = fmt.Errorf("failed to parse expireTime: %s, causing error: %s", expireTime, parseErr)
		return 0, err
	}

	// Set timestamps
	expireTimeInSeconds := uint32(expireTime64)
	currentTimestamp := uint32(time.Now().UTC().Unix())
	timestamp = currentTimestamp + expireTimeInSeconds

	return timestamp, nil
}

func GenerateRtcToken(appID, appCertificate, channelName, uidStr, tokentype string, role rtctokenbuilder.Role, expireTimestamp uint32) (rtcToken string, err error) {
	if tokentype == "userAccount" {
		log.Printf("Building Token with userAccount: %s\n", uidStr)
		rtcToken, err = rtctokenbuilder.BuildTokenWithUserAccount(appID, appCertificate, channelName, uidStr, role, expireTimestamp)
		return rtcToken, err

	} else if tokentype == "uid" {
		uid64, parseErr := strconv.ParseUint(uidStr, 10, 64)
		// check if conversion fails
		if parseErr != nil {
			err = fmt.Errorf("failed to parse uidStr: %s, to uint causing error: %s", uidStr, parseErr)
			return "", err
		}

		uid := uint32(uid64) // convert uid from uint64 to uint 32
		log.Printf("Building Token with uid: %d\n", uid)
		rtcToken, err = rtctokenbuilder.BuildTokenWithUID(appID, appCertificate, channelName, uid, role, expireTimestamp)
		return rtcToken, err

	} else {
		err = fmt.Errorf("failed to generate RTC token for Unknown Tokentype: %s", tokentype)
		log.Println(err)
		return "", err
	}
}
