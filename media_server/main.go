package main

import (
	// Standard Packages

	// Local Packages
	"media-server/handlers"

	// Third-Party Packages
	"github.com/gin-gonic/gin"
)

func main() {
	api := gin.Default()

	var port = "8080"

	api.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "pong",
		})
	})

	api.Use(nocache())
	// api.GET("rid/:channelName/:customerKey/:customerSecret/:appId/:recordingId/:cred/", handlers.GetResourceID)
	// api.GET("start/:appId/:channelName/:recordingId/:resourceId/:customerKey/:customerSecret/:token/:maxIdleTime/:bucketId/:bucketAccessKey/:bucketSecretKey/:userUid/:dir1/:dir2/:cred/", handlers.StartRecording)
	// api.GET("stop/:channelName/:customerKey/:customerSecret/:appId/:recordingId/:sid/:resourceId/:cred/", handlers.StopRecording)
	api.GET("rid", handlers.GetResourceID)
	api.GET("rtc", handlers.GetRTCToken)
	api.Run(":" + port)
}

func nocache() gin.HandlerFunc {
	return func(c *gin.Context) {
		// set headers
		c.Header("Cache-Control", "private, no-cache, no-store, must-revalidate")
		c.Header("Expires", "-1")
		c.Header("Pragma", "no-cache")
		c.Header("Access-Control-Allow-Origin", "*")
	}
}
