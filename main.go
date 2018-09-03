package main

import (
	"net/http"
	"os"
	"github.com/gin-gonic/gin"
	"github.com/go-redis/redis"
	"strings"
)

var DB = make(map[string]string)
var redisClient = redis.NewClient(&redis.Options{Addr: os.Getenv("REDIS_SERVER")})

func setupRouter() *gin.Engine {
	r := gin.Default()

	r.GET("/fruit", func(c *gin.Context) {
		namesQuery := c.Query("names")
		prices := make(map[string]string)
		if namesQuery != "" {
			names := strings.Split(namesQuery, ",")
			for _, name := range names {
				prices[name] = getPrice(name)
			}
		}
		c.JSON(http.StatusOK, prices)
	})

	return r
}

func initRedis()  {
	redisClient.Set("apple", "10", 0)
	redisClient.Set("orange", "5", 0)
	redisClient.Set("grape", "1", 0)
	redisClient.Set("pineapple", "15", 0)
	redisClient.Set("durian", "20", 0)
}

func getPrice(fruit string) string {
	val, err := redisClient.Get(fruit).Result()
	if err == redis.Nil || err != nil {
		return "N/A"
	} else {
		return val
	}
}

func main() {
	initRedis()
	r := setupRouter()
	// Listen and Server in 0.0.0.0:8080
	r.Run(":8080")
}
