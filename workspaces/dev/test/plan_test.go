package test

import (
	"testing"
	"time"

	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestSimpleTFPlan(t *testing.T) {
	terraoformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../",
	})

	planTest(t, terraoformOptions)
}

func TestCompleteTFPlan(t *testing.T) {
	terraoformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/complete/",
	})

	planTest(t, terraoformOptions)
}

func planTest(t *testing.T, terraoformOptions *terraform.Options) {
	defer terraform.Destroy(t, terraoformOptions)

	terraform.InitAndApply(t, terraoformOptions)

	load_balancer_dns_name := terraform.Output(t, terraoformOptions, "acm_domain_name")

	url := "http://" + load_balancer_dns_name

	http_helper.HttpGetWithRetry(t, url, nil, 200, "Welcome to nginx", 30, 5*time.Second)
}
