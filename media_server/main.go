package main

import (
	"log"
	"media-server/handlers"
	"media-server/utils"

	"github.com/gin-gonic/gin"
)

func main() {
	// Set ENVs
	err := utils.SetEnv(true)

	if err != nil {
		log.Fatal("Error loading envs: " + err.Error())
		return
	}

	// Initialize Server
	api := gin.Default()

	var port = "8080"

	api.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "pong",
		})
	})

	api.Use(nocache())
	api.GET("rid", handlers.GetResourceID)
	api.GET("rtc", handlers.GetRTCToken)
	api.POST("start", handlers.StartRecording)
	api.POST("stop", handlers.StopRecording)
	api.POST("process", handlers.Process)
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
