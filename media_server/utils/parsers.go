package utils

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"media-server/models"

	"github.com/gin-gonic/gin"
)

// ⬇️ STOP
func ParseStartBody(c *gin.Context) (data models.StartBody, err error) {
	raw, err := ioutil.ReadAll(c.Request.Body)

	if err != nil {
		// Handle error
		err := fmt.Errorf("ensure that json body is valid")

		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": "Failed to read body request. " + err.Error(),
		})
		return data, err
	}

	isValid := json.Valid(raw)

	if !isValid {
		// Handle error
		err := fmt.Errorf("ensure that json body is valid")

		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": "Failed to parse body request. " + err.Error(),
		})
		return data, err
	}

	err = json.Unmarshal(raw, &data)

	if err != nil {
		// Handle error
		err := fmt.Errorf("ensure that json body is valid")

		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": "Failed to parse body request. " + err.Error(),
		})
		return data, err
	}

	isBodyEmpty := ContainsEmpty(data.AppID,
		data.ChannelName,
		data.CustomerKey,
		data.CustomerSecret,
		data.ResourceID,
		data.Token,
		data.MaxIdleTime,
		data.RecordingID,
		data.UserID,
	)

	isStorageEmpty := ContainsEmpty(
		data.Storage.BucketAccessKey,
		data.Storage.BucketID,
		data.Storage.BucketSecretKey,
		data.Storage.Dir1,
		data.Storage.Dir2,
	)

	if isBodyEmpty || isStorageEmpty {
		// Handle error
		err := fmt.Errorf("required body parameters are empty")

		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": "Failed to parse body request. " + err.Error(),
		})
		return data, err
	}

	return data, nil
}

// ⬇️ STOP
func ParseStopBody(c *gin.Context) (data models.StopBody, err error) {
	raw, err := ioutil.ReadAll(c.Request.Body)

	if err != nil {
		// Handle error
		err := fmt.Errorf("ensure that json body is valid")

		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": "Failed to read body request. " + err.Error(),
		})
		return data, err
	}

	isValid := json.Valid(raw)

	if !isValid {
		// Handle error
		err := fmt.Errorf("ensure that json body is valid")

		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": "Failed to parse body request. " + err.Error(),
		})
		return data, err
	}

	err = json.Unmarshal(raw, &data)

	if err != nil {
		// Handle error
		err := fmt.Errorf("ensure that json body is valid")

		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": "Failed to parse body request. " + err.Error(),
		})
		return data, err
	}

	isEmpty := ContainsEmpty(data.AppID,
		data.ChannelName,
		data.CustomerKey,
		data.CustomerSecret,
		data.ResourceID,
		data.SID,
		data.RecordingID,
		data.BucketID,
		data.Collection,
		data.IncidentID,
	)

	if isEmpty {
		// Handle error
		err := fmt.Errorf("required body parameters are empty")

		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": "Failed to parse body request. " + err.Error(),
		})
		return data, err
	}

	return data, nil
}

// ⬇️ RID
func ParseRIDBody(c *gin.Context) (data models.RIDBody, err error) {
	raw, err := ioutil.ReadAll(c.Request.Body)

	if err != nil {
		// Handle error
		err := fmt.Errorf("ensure that json body is valid")

		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": "Failed to read body request. " + err.Error(),
		})
		return data, err
	}

	isValid := json.Valid(raw)

	if !isValid {
		// Handle error
		err := fmt.Errorf("ensure that json body is valid")

		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": "Failed to parse body request. " + err.Error(),
		})
		return data, err
	}

	err = json.Unmarshal(raw, &data)

	if err != nil {
		// Handle error
		err := fmt.Errorf("ensure that json body is valid")

		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": "Failed to parse body request. " + err.Error(),
		})
		return data, err
	}

	isEmpty := ContainsEmpty(
		data.AppID,
		data.ChannelName,
		data.CustomerKey,
		data.CustomerSecret,
		data.RecordingID,
	)

	if isEmpty {
		// Handle error
		err := fmt.Errorf("required body parameters are empty")

		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": "Failed to parse body request. " + err.Error(),
		})
		return data, err
	}

	return data, nil
}

// ⬇️ RTC
func ParseRTCBody(c *gin.Context) (data models.RTCBody, err error) {
	raw, err := ioutil.ReadAll(c.Request.Body)

	if err != nil {
		// Handle error
		err := fmt.Errorf("ensure that json body is valid")

		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": "Failed to read body request. " + err.Error(),
		})
		return data, err
	}

	isValid := json.Valid(raw)

	if !isValid {
		// Handle error
		err := fmt.Errorf("ensure that json body is valid")

		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": "Failed to parse body request. " + err.Error(),
		})
		return data, err
	}

	err = json.Unmarshal(raw, &data)

	if err != nil {
		// Handle error
		err := fmt.Errorf("ensure that json body is valid")

		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": "Failed to parse body request. " + err.Error(),
		})
		return data, err
	}

	isEmpty := ContainsEmpty(
		data.Role,
		data.UserID,
		data.AppCertificate,
		data.AppID,
		data.TokenType,
		data.ChannelName,
	)

	if isEmpty {
		// Handle error
		err := fmt.Errorf("required body parameters are empty")

		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": "Failed to parse body request. " + err.Error(),
		})
		return data, err
	}

	return data, nil
}

// ⬇️ RID
func ParseProcessResponse(c *gin.Context) (data models.ProcessBody, err error) {
	raw, err := ioutil.ReadAll(c.Request.Body)

	if err != nil {
		// Handle error
		err := fmt.Errorf("ensure that json body is valid")

		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": "Failed to read body request. " + err.Error(),
		})
		return data, err
	}

	isValid := json.Valid(raw)

	if !isValid {
		// Handle error
		err := fmt.Errorf("ensure that json body is valid")

		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": "Failed to parse body request. " + err.Error(),
		})
		return data, err
	}

	err = json.Unmarshal(raw, &data)

	if err != nil {
		// Handle error
		err := fmt.Errorf("ensure that json body is valid")

		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": "Failed to parse body request. " + err.Error(),
		})
		return data, err
	}

	isEmpty := ContainsEmpty(
		data.BucketID,
		data.OutputFilename,
		data.WatermarkFilename,
		data.ThumbnailFilename,
		data.Path,
	)

	if isEmpty {
		// Handle error
		err := fmt.Errorf("required body parameters are empty")

		c.AbortWithStatusJSON(400, gin.H{
			"status":  400,
			"message": "Failed to parse body request. " + err.Error(),
		})
		return data, err
	}

	return data, nil
}
