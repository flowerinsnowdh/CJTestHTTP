package testhttp

import net.http.ServerBuilder
import std.fs.File

main() : Int64 {    
    let server = ServerBuilder()
        .addr("127.0.0.1")
        .port(8080)
        .build()

    server.distributor
        .register("/", { context =>
            let respBuilder = context.responseBuilder

            let body = "<!DOCTYPE html><head><meta lang=\"zh-cmn-Hans\"><meta charset=\"UTF-8\"><title>Hello world!</title></head><body><h1>Hello world!</h1></body>"
            respBuilder.header("content-type", "text/html; charset=utf-8")
            respBuilder.header("content-length", body.size.toString())
            respBuilder.body(body)
        })
    
    server.distributor
        .register("/cangjie", {context => 
            let respBuilder = context.responseBuilder

            respBuilder.status(301)
            respBuilder.header("location", "https://developer.huawei.com/consumer/cn/cangjie/")
        })

    server.distributor
        .register("/favicon.ico", { context =>
            let respBuilder = context.responseBuilder

            respBuilder.body(File.openRead("favicon.ico"))
        })

    println("Server listening on 127.0.0.1:8080")
    server.serve()
    return 0
}