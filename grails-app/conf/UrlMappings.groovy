class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?" {
            constraints {
                // apply constraints here
            }
        }

//        "/"(view: "/index")
        "/"(controller: 'global')
        "500"(view: '/error')
        "/resource"(view: "/example/resource")
        "/member/import"(view: "/member/import")
    }
}
