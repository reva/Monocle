#!/bin/sh

# $1 = the tag node from here: http://hg.openjdk.java.net/openjfx/8u-dev/rt/tags
# $2 = the java to use, must match the tag. The monocle jar will also be put there

export JAVA_HOME=$2
echo "Java Home: $JAVA_HOME"
rm -rf src
mkdir -p src/main/java
mkdir -p src/main/resources
wget http://hg.openjdk.java.net/openjfx/8u-dev/rt/archive/$1.zip/modules/graphics/src/main/java/com/sun/glass/ui/monocle/ -O java.zip
wget http://hg.openjdk.java.net/openjfx/8u-dev/rt/archive/$1.zip/modules/graphics/src/main/resources/com/sun/glass/ui/monocle/ -O resources.zip
unzip java.zip -d src/main/java
unzip resources.zip -d src/main/resources
cp -r src/main/java/rt-$1/modules/graphics/src/main src
cp -r src/main/resources/rt-$1/modules/graphics/src/main src
rm -rf src/main/java/rt-$1
rm -rf src/main/resources/rt-$1
rm java.zip
rm resources.zip
gradle clean jar
sudo cp cp build/libs/openjfx-monocle-*.jar $JAVA_HOME/jre/lib/ext
