ThisBuild / organization := "aec"
ThisBuild / scalaVersion := "2.13.10"

val chiselVersion = "3.5.6"

libraryDependencies ++= Seq(
  "edu.berkeley.cs" %% "chisel3" % chiselVersion,
  "org.scalatest" %% "scalatest" % "3.2.0" % Test,
  "edu.berkeley.cs" %% "chiseltest" % "0.5.6" % Test
)
addCompilerPlugin("edu.berkeley.cs" % "chisel3-plugin" % chiselVersion cross CrossVersion.full)
scalacOptions ++= Seq("-language:reflectiveCalls", "-deprecation", "-feature")

lazy val SfuTest = config("sfu") extend Test
configs(SfuTest)
inConfig(SfuTest)(Defaults.testSettings)
SfuTest / scalaSource := baseDirectory.value / "src" / "sfu-test" / "scala"
SfuTest / parallelExecution := false
