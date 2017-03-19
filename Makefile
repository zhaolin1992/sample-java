git_version = $$(git branch 2>/dev/null | sed -e '/^[^*]/d'-e's/* \(.*\)/\1/')
npm_bin= $$(npm bin)

all: test
install:
	npm install
test-pc-browser: server
	mvn -s settings.xml clean install
	mvn test -Dtest=DesktopSampleTest
travis-pc-browser: install server
	npm i macaca-cli -g --unsafe-perm=true
	npm i macaca-electron -g --unsafe-perm=true
	mvn -s settings.xml clean install
	mvn test -Dtest=DesktopSampleTest
travis-android: install server
	npm install macaca-android -g --unsafe-perm=true
	${npm_bin}/macaca doctor
	sleep 10s
	mvn -s settings.xml clean install -Dmaven.test.skip=true
	mvn test -Dtest=AndroidSampleTest
travis-ios: install server
	npm install macaca-ios -g --unsafe-perm=true
	${npm_bin}/macaca doctor
	sleep 10s
	mvn -s settings.xml clean install -Dmaven.test.skip=true
	mvn test -Dtest=IosSampleTest
travis-android-browser: install server
	npm install macaca-android -g --unsafe-perm=true
	${npm_bin}/macaca doctor
	mvn -s settings.xml clean install -Dmaven.test.skip=true
	mvn test -Dtest=H5SampleTest
server:
	${npm_bin}/macaca server --verbose &
	sleep 5
.PHONY: test
