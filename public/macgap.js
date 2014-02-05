// In this file we'll add common javascript code for all apps

// Method stringToFile for String objects. Example: "Hello!".stringToFile("/Users/jhon/hello.txt")
String.prototype.stringToFile = function (path) {macgap.fs.stringToFile({'path': path, 'data': this.toString()})};