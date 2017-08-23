# Building JavaNSQClient 

Due to name lookups, running the unit tests requires shutting down docker360
nsq-related services (nsqlookupd, nsqd, and optionally nsqadmin) and running
them in a local shell. Once that has been done, you may run

```sh
make build
```

To build without testing
```sh
make no-test
```

# Adding/updating JavaNSQClient to a Project

Until such time as all of our changes are incorporated into the upstream project,
adding JavaNSQClient involves building the client locally and adding the `.jar`
file to the project. We are using the convention of changing the version to
`LIFE360#` where `#` is the build number.

```sh
# in the project
mkdir libs

# in JavaNSQClient 
make build
cp target/nsq-client-1.0.0.RC4.jar <PROJECT_DIR>/libs/nsq-client-1.0.0.LIFE3609.jar

# in the project
vi build.gradle
# add
repositories {
    flatDir name: "localLibs", dirs: "$projectDir/libs"
    ...
}
# add
dependencies {
    ...
    // log4j (for nsq and must precede nsq)
    compile group: 'org.apache.logging.log4j', name: 'log4j-api', version: '2.7'
    compile group: 'org.apache.logging.log4j', name: 'log4j-core', version: '2.7'

    // nsq client
    compile group: 'com.github.brainlag', name: 'nsq-client', version: '1.0.0.LIFE3609'

    // netty (for nsq)
    compile group: 'io.netty', name: 'netty-all', version: '4.0.39.Final'
    ...
}

git add build.gradle libs/nsq-client-1.0.0.LIFE3609.jar
git commit
```
