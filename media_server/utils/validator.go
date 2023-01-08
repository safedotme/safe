package utils

import (
	"encoding/base64"
	"log"
	"os"

	"github.com/gin-gonic/gin"
)

func AuthorizeRequest(c *gin.Context) (authorized bool) {
	key := c.Query("key")

	if key == "" {
		c.AbortWithStatusJSON(401, gin.H{
			"status":  401,
			"message": "Unauthorized request. Credentials were not passed.",
		})
		return false
	}

	if !Validate(key) {
		c.AbortWithStatusJSON(401, gin.H{
			"message": "Unauthorized request. Credentials were invalid.",
			"status":  401,
		})
		return false
	}

	return true
}

func Validate(userKey string) bool {
	keyEnv, keyExists := os.LookupEnv("MEDIA_KEY")
	secretEnv, secretExists := os.LookupEnv("MEDIA_SECRET")

	if !keyExists || !secretExists {
		log.Fatal("FATAL ERROR: ENV not properly configured, check key and secret")
		return false
	}

	plainCredentials := keyEnv + ":" + secretEnv
	base64Credentials := base64.StdEncoding.EncodeToString([]byte(plainCredentials))

	return base64Credentials == userKey
}
