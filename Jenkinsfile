pipeline {
  agent { label 'ubuntu-18.04' }
  triggers { upstream( upstreamProjects: 'IncludeOS/IncludeOS/master, IncludeOS/IncludeOS/dev', threshold: hudson.model.Result.SUCCESS ) }
  options { checkoutToSubdirectory('src') }
  environment {
    CONAN_USER_HOME = "${env.WORKSPACE}"
    PROFILE_x86_64 = 'clang-6.0-linux-x86_64'
    SRC = "${env.WORKSPACE}/src"
  }

  stages {
    stage('Setup') {
      steps {
        sh script: "ls -A | grep -v src | xargs rm -r || :", label: "Clean workspace"
        sh script: "conan config install https://github.com/includeos/conan_config.git", label: "conan config install"
      }
    }
    stage('build example') {
      steps {
        dir('build_example') {
          sh script: "conan install $SRC -pr $PROFILE_x86_64", label: "Conan install"
          sh script: ". ./activate.sh; cmake $SRC",label: "Cmake"
          sh script: "cmake --build .", label: "building example"
        }
      }
    }
  }
}
