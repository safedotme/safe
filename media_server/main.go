package main

import (
	// Standard Packages
	"os"

	// Local Packages
	"media-server/handlers"

	// Third-Party Packages
	"github.com/gin-gonic/gin"
)

func main() {
	api := gin.Default()

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	api.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "pong",
		})
	})

	api.Use(nocache())
	api.GET("rtc/:channelName/:role/:tokentype/:uid/:id/:cert/:cred/", handlers.GetRtcToken)
	api.GET("rid/:channelName/:customerKey/:customerSecret/:appId/:recordingId/:cred/", handlers.GetResourceID)
	api.GET("start/:appId/:channelName/:recordingId/:resourceId/:customerKey/:customerSecret/:token/:maxIdleTime/:bucketId/:bucketAccessKey/:bucketSecretKey/:userUid/:dir1/:dir2/:cred/", handlers.StartRecording)
	api.GET("stop/:channelName/:customerKey/:customerSecret/:appId/:recordingId/:sid/:resourceId/:cred/", handlers.StopRecording)
	api.Run(":" + port)
} // rtc/safe/publisher/userAccount/1948/53afc3aa11c84a99bdd7444e816d39f3/90f3ea4645be494982e27029f406cf40/ZUNKc3hrYXpuYWlhdXBWTVdhNnhtb3RLUGcyWFdNOnlYNjY2em5IQktSbTJLWWE2ajNtckdEdmR6a0FqTA==/

func nocache() gin.HandlerFunc {
	return func(c *gin.Context) {
		// set headers
		c.Header("Cache-Control", "private, no-cache, no-store, must-revalidate")
		c.Header("Expires", "-1")
		c.Header("Pragma", "no-cache")
		c.Header("Access-Control-Allow-Origin", "*")
	}
}
