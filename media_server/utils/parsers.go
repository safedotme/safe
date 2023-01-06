package utils

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"media-server/models"

	"github.com/gin-gonic/gin"
)

// func ParseStopParams(c *gin.Context) (channelName, customerKey, customerSecret, appId, recordingId, sid, resourceId, cred string) {
// 	channelName = Decode(c.Param("channelName"))
// 	customerKey = Decode(c.Param("customerKey"))
// 	customerSecret = Decode(c.Param("customerSecret"))
// 	appId = Decode(c.Param("appId"))
// 	recordingId = Decode(c.Param("recordingId"))
// 	sid = Decode(c.Param("sid"))
// 	resourceId = Decode(c.Param("resourceId"))
// 	cred = c.Param("cred")

// 	return channelName, customerKey, customerSecret, appId, recordingId, sid, resourceId, cred
// }

// func ParseRidParams(c *gin.Context) (channelName, customerKey, customerSecret, appId, recordingId, cred string) {

// 	channelName = Decode(c.Param("channelName"))
// 	customerKey = Decode(c.Param("customerKey"))
// 	customerSecret = Decode(c.Param("customerSecret"))
// 	appId = Decode(c.Param("appId"))
// 	recordingId = Decode(c.Param("recordingId"))
// 	cred = c.Param("cred")

// 	return channelName, customerKey, customerSecret, appId, recordingId, cred
// }

// func ParseStartParams(c *gin.Context) (appId, channelName, recordingId, resourceId, customerKey, customerSecret, token, maxIdleTime, bucketId, bucketAccessKey, bucketSecretKey, userUid, dir1, dir2, cred string) {
// 	appId = Decode(c.Param("appId"))
// 	channelName = Decode(c.Param("channelName"))
// 	recordingId = Decode(c.Param("recordingId"))
// 	resourceId = Decode(c.Param("resourceId"))
// 	customerKey = Decode(c.Param("customerKey"))
// 	customerSecret = Decode(c.Param("customerSecret"))
// 	token = Decode(c.Param("token"))
// 	maxIdleTime = Decode(c.Param("maxIdleTime"))

// 	bucketId = Decode(c.Param("bucketId"))
// 	bucketAccessKey = Decode(c.Param("bucketAccessKey"))
// 	bucketSecretKey = Decode(c.Param("bucketSecretKey"))
// 	userUid = Decode(c.Param("userUid"))
// 	dir1 = Decode(c.Param("dir1"))
// 	dir2 = Decode(c.Param("dir2"))
// 	cred = c.Param("cred")

// 	return appId, channelName, recordingId, resourceId, customerKey, customerSecret, token, maxIdleTime, bucketId, bucketAccessKey, bucketSecretKey, userUid, dir1, dir2, cred
// }

// func ParseRtcParams(c *gin.Context) (id, cert, channelName, tokentype, uidStr, cred string, role rtctokenbuilder.Role, expireTimestamp uint32, err error) {

// 	id = Decode(c.Param("id"))
// 	cert = Decode(c.Param("cert"))
// 	channelName = Decode(c.Param("channelName"))
// 	roleStr := Decode(c.Param("role"))
// 	tokentype = Decode(c.Param("tokentype"))
// 	cred = c.Param("cred")
// 	uidStr = Decode(c.Param("uid"))
// expireTime := c.DefaultQuery("expiry", "3600")

// 	if roleStr == "publisher" {
// 		role = rtctokenbuilder.RolePublisher
// 	} else {
// 		role = rtctokenbuilder.RoleSubscriber
// 	}

// 	expireTime64, parseErr := strconv.ParseUint(expireTime, 10, 64)
// 	if parseErr != nil {
// 		// if string conversion fails return an error
// 		err = fmt.Errorf("failed to parse expireTime: %s, causing error: %s", expireTime, parseErr)
// 	}

// 	// set timestamps
// 	expireTimeInSeconds := uint32(expireTime64)
// 	currentTimestamp := uint32(time.Now().UTC().Unix())
// 	expireTimestamp = currentTimestamp + expireTimeInSeconds

// 	return id, cert, channelName, tokentype, uidStr, cred, role, expireTimestamp, err
// }

func ParseRTCBody(c *gin.Context) (data models.RTCBody, err error) {
	body, err := ioutil.ReadAll(c.Request.Body)
	var decoded models.RTCBody

	if err != nil {
		// Handle error
		err := fmt.Errorf("ensure that json body is valid")

		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": "Failed to read body request. " + err.Error(),
		})
		return decoded, err
	}

	isValid := json.Valid(body)

	if !isValid {
		// Handle error
		err := fmt.Errorf("ensure that json body is valid")

		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": "Failed to parse body request. " + err.Error(),
		})
		return decoded, err
	}

	err = json.Unmarshal(body, &decoded)

	if err != nil {
		// Handle error
		err := fmt.Errorf("ensure that json body is valid")

		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": "Failed to parse body request. " + err.Error(),
		})
		return decoded, err
	}

	isEmpty := ContainsEmpty(decoded.Role, decoded.UserID, decoded.AppCertificate, decoded.AppID, decoded.TokenType, decoded.ChannelName)

	if isEmpty {
		// Handle error
		err := fmt.Errorf("required body parameters are empty")

		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": "Failed to parse body request. " + err.Error(),
		})
		return decoded, err
	}

	return decoded, nil
}
