#!groovy

@Library('utils') _

node('jenkins-docker-3') {
  ws {
    try {
      // Jenkins pipelines are "dumb" in that regards that it does not do
      // anything unless you explicitly tells it so. Here we checkout the
      // repository in order to the source code into the workspace.
      stage('Checkout') {
        checkout scm
      }

      // Check if this is the master brach
      isMaster = env.BRANCH_NAME == 'master'

      def tflintImage = 'wata727/tflint:latest'
      def tflintArgs = ["--entrypoint=''"].join(' ')

      stage("Terraform Lint") {
        docker.image(tflintImage).inside(tflintArgs) {
          sh 'tflint --error-with-issues'
        }
      }

    // Catch abort build interrupts and possible handle them differently. They
    // should not be reported as build failures to Slack etc.
    } catch (InterruptedException e) {
      throw e

    // Catch all build failures and report them to Slack etc here.
    } catch (e) {
      throw e

    // Clean up the workspace before exiting. Wait for Jenkins' asynchronous
    // resource disposer to pick up before we close the connection to the worker
    // node.
    } finally {
      step([$class: 'WsCleanup'])
      sleep 10
    }
  }
}
