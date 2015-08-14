run = ($httpBackend) ->

  $httpBackend.whenGET(/templates\//).passThrough()

  mockResponse = (email) ->
    user:
      id:         1
      email:      email
      auth_token: "sP3hoKN5-y-tRtagTf2B"
      created_at: "2015-08-09T06:00:37.484Z"
      updated_at: "2015-08-09T06:00:37.484Z"
      category_ids: []

  # users controller
  $httpBackend.whenGET(/\/api\/users\/.*/).respond (method, url, data, headers) ->
    console.log "#{method} - #{url}"
    console.log data
    console.log headers
    return [200, mockResponse("johndoe@john")]

  $httpBackend.whenPOST('/api/users').respond (method, url, data, headers) ->
    console.log "#{method} - #{url}"
    console.log data
    console.log headers
    user = angular.fromJson data
    return [201, mockResponse(user.email)]

  $httpBackend.whenPUT(/\/api\/users\/.*/).respond (method, url, data, headers) ->
    console.log "#{method} - #{url}"
    console.log data
    console.log headers
    user = angular.fromJson data
    return [200, mockResponse(user.email)]

  $httpBackend.whenDELETE(/\/api\/users\/.*/).respond (method, url, data, headers) ->
    console.log "#{method} - #{url}"
    console.log data
    console.log headers
    return [204]

  # sessions controller
  $httpBackend.whenPOST('/api/sessions').respond (method, url, data, headers) ->
    console.log "#{method} - #{url}"
    console.log data
    console.log headers
    user = angular.fromJson data
    return [200, mockResponse(user.email)]

  $httpBackend.whenDELETE(/\/api\/sessions\/.*/).respond (method, url, data, headers) ->
    console.log "#{method} - #{url}"
    console.log data
    console.log headers
    return [204]


  # category controller
  categoryShow =
    category:
      id: 1
      name: "Electric Witch"
      description: "With my mind on my money why is you real deal Holyfield Long Beach bubbles in the tub rizzide like every single day fizzle rolling down the street. Realness tha shiznit recognize smokin' indo guess what? nasty the diggy the dopest it's 1993. Rizzide the Magic Johnson of rap how we do it every single one plizzay nothing can save ya. Feel the breeze tha shiznit Snoop laid back plizzay used to sell loot the Dogg Pound put ya choppers up pizzle."
      created_at: "2015-08-11T06:36:53.591Z"
      updated_at: "2015-08-11T06:36:53.591Z"
      item_ids: []
      user:
      	id: 1
      	email: "nick_dietrich@greenholtrippin.info"
      	auth_token: "c1sszoABHfAYZxh6USd5"
      	created_at: "2015-08-11T06:36:53.486Z"
      	updated_at: "2015-08-11T06:36:53.486Z"
      	category_ids: [
      		1
      		2
      	]

  categoryIndex =
     categories: [
       {
       	id: 1
       	name: "The Monster from 9761 Leagues"
       	description: "Drop it like it's hot Snoopy bionic Coupe de Ville guess what?. Doggfada smokin' indo make a few ends with my mind on my money televizzle fo shizzle. In tha hizzle drizzle gizzo zig zag smoke Mr. Buckwort smokin' indo roll with it's 1993. Mr. buckwort eighty degrees Long Beach used to sell loot for the hustlers you talk too much Doggfada if you was me and I was you."
       	created_at: "2015-08-11T06:36:52.464Z"
       	updated_at: "2015-08-11T06:36:52.464Z"
       	item_ids: [
       		1
       		2
       		3
       	]
       	user:
       		id: 1
       		email: "antonetta@wiegand.co.uk"
       		auth_token: "x9Zjz3J1svcq-Avbx26e"
       		created_at: "2015-08-11T06:36:52.433Z"
       		updated_at: "2015-08-11T06:36:52.433Z"
       		category_ids: [
       			1
       			2
       			3
       			4
       		]
       }
       {
       	id: 2
       	name: "Dr. Fly"
       	description: "The s oh yes rizzide make a few ends put ya choppers up plizzay. Hizzouse nasty Long Beach put ya choppers up for the Gs at ease waddup. Fizzle Doggfada fo shizzle now I'm on parole bubbles in the tub recognize the dopest. You talk too much used to sell loot drop it like it's hot smokin' weed why is you. Fo rizzle used to sell loot the dopest drizzle put ya choppers up your chrome realer plizzay zig zag smoke."
       	created_at: "2015-08-11T06:36:52.613Z"
       	updated_at: "2015-08-11T06:36:52.613Z"
       	item_ids: []
       	user:
       		id: 1
       		email: "antonetta@wiegand.co.uk"
       		auth_token: "x9Zjz3J1svcq-Avbx26e"
       		created_at: "2015-08-11T06:36:52.433Z"
       		updated_at: "2015-08-11T06:36:52.433Z"
       		category_ids: [
       			1
       			2
       			3
       			4
       		]
       }
     ]
  
  $httpBackend.whenGET("/api/categories").respond (method, url, data, headers) ->
    console.log "#{method} - #{url}"
    console.log data
    console.log headers
    return [200, categoryIndex]

  $httpBackend.whenPOST("/api/categories").respond (method, url, data, headers) ->
    console.log "#{method} - #{url}"
    console.log data
    console.log headers
    return [200, categoryShow]

  $httpBackend.whenPUT(/\/api\/categories\/.*/).respond (method, url, data, headers) ->
    console.log "#{method} - #{url}"
    console.log data
    console.log headers
    return [200, categoryShow]

  $httpBackend.whenDELETE(/\/api\/categories\/.*/).respond (method, url, data, headers) ->
    console.log "#{method} - #{url}"
    console.log data
    console.log headers
    return [204]


  picUrl0 = "/app/test/pictures/test0.png"
  picUrl1 = "/app/test/pictures/test1.png"
  picUrl2 = "/app/test/pictures/test2.png"

  itemShow =
    item:
      id: 1
      word: "fizzle Long Beach"
      sentence: "The s oh yes with my mind on my money every single one gold chain plizzay for the Gs feel the breeze the Magic Johnson of rap. Real deal holyfield tha shiznit the Magic Johnson of rap make a few ends the diggy the S oh yes if the ride is more fly, then you must buy. The lbc gold chain Mr. Buckwort zig zag smoke waddup in tha hizzle Long Beach Coupe de Ville. Smokin' indo smokin' weed gold chain if you was me and I was you used to sell loot put ya choppers up. Put ya choppers up rizzoad it's 1993 every single one rizzide."
      meaning: "Doggfada and my money on my mind if the ride is more fly, then you must buy rolling down the street for the Gs make a few ends. Plizzay for the Gs make a few ends bionic nothing can save ya if you was me and I was you. For the hustlers if the ride is more fly, then you must buy rizzide your chrome bubbles in the tub. Waddup used to sell loot Doggfada rizzide drizzle like every single day. Realer guess what? the diggy you talk too much the dopest used to sell loot your chrome eighty degrees."
      picture: picUrl0
      created_at: "2015-08-11T06:36:55.668Z"
      updated_at: "2015-08-11T06:36:55.668Z"
      category:
        id: 1
        name: "Time of the Green Identity"
        description: "The lbc pizzle gold chain fo shizzle Coupe de Ville. Gizzo Snoop roll with may I make a few ends gold chain. Make a few ends drop it like it's hot sippin' on gin and juice Snoop the Magic Johnson of rap the diggy tha shiznit may I roll with. Through all the drama I love my momma the Magic Johnson of rap your chrome laid back real deal Holyfield gold chain how we do it smokin' weed."
        created_at: "2015-08-11T06:36:55.631Z"
        updated_at: "2015-08-11T06:36:55.631Z"
        item_ids: [
          1
        ]
        user:
          id: 1
          email: "cesar.graham@thielpaucek.us"
          auth_token: "PwieFd-GJc3VuAQLEK5R"
          created_at: "2015-08-11T06:36:55.621Z"
          updated_at: "2015-08-11T06:36:55.621Z"
          category_ids: [
            1
          ]

  itemIndex =
    items: [
      {
        id: 1
        word: "waddup tha shiznit"
        sentence: "Smokin' weed Snoopy you talk too much like every single day rizzide fo rizzle why is you. In tha hizzle recognize feel the breeze fo shizzle like every single day rizzide waddup. If the ride is more fly, then you must buy fizzle gizzo the S oh yes realness if you was me and I was you. Smokin' indo roll with rizzoad nasty at ease if you was me and I was you bubbles in the tub Snoopy. Roll with for the hustlers nothing can save ya tha shiznit hizzouse I love my momma Doggfada in tha hizzle."
        meaning: "Real deal holyfield fo rizzle Mr. Buckwort tha shiznit drizzle in tha hizzle used to sell loot. Fo rizzle now I'm"
        picture:   picUrl0
        created_at: "2015-08-11T06:36:54.997Z"
        updated_at: "2015-08-11T06:36:54.997Z"
        category:
          id: 1
          name: "I Married a Action Gypsy"
          description: "Waddup the Magic Johnson of rap used to sell loot may I pizzle. Realness plizzay pizzle drop it like it's hot may I if you was me and I was you. Tha shiznit the dopest every single one drop it like it's hot zig zag smoke smokin' indo Long Beach fo rizzle in tha hizzle."
          created_at: "2015-08-11T06:36:54.967Z"
          updated_at: "2015-08-11T06:36:54.967Z"
          item_ids: [
            1
            2
            3
          ]
          user:
            id: 1
            email: "natalia@mante.name"
            auth_token: "MHynn_e7ssHxsCDwhz_s"
            created_at: "2015-08-11T06:36:54.963Z"
            updated_at: "2015-08-11T06:36:54.963Z"
            category_ids: [
              1
            ]
      }
      {
        id: 2
        word: "Snoopy Coupe de Ville"
        sentence: "Sippin' on gin and juice if the ride is more fly, then you must buy through all the drama it's 1993 may I hizzouse. Televizzle smokin' indo Snoop the Dogg Pound Snoopy gizzo at ease. Like every single day televizzle Doggfada rolling down the street may I smokin' weed sippin' on gin and juice recognize. The diggy realer bionic drizzle feel the breeze if the ride is more fly, then you must buy every single one."
        meaning: "The diggy guess what? nothing can save ya everybody got they cups the S oh yes in tha hizzle. Tha dizzle tha shiznit fo rizzle drop it like it's hot"
        picture: picUrl1
        created_at: "2015-08-11T06:36:55.030Z"
        updated_at: "2015-08-11T06:36:55.030Z"
        category:
          id: 1
          name: "I Married a Action Gypsy"
          description: "Waddup the Magic Johnson of rap used to sell loot may I pizzle. Realness plizzay pizzle drop it like it's hot may I if you was me and I was you. Tha shiznit the dopest every single one drop it like it's hot zig zag smoke smokin' indo Long Beach fo rizzle in tha hizzle."
          created_at: "2015-08-11T06:36:54.967Z"
          updated_at: "2015-08-11T06:36:54.967Z"
          item_ids: [
            1
            2
            3
          ]
          user:
            id: 1
            email: "natalia@mante.name"
            auth_token: "MHynn_e7ssHxsCDwhz_s"
            created_at: "2015-08-11T06:36:54.963Z"
            updated_at: "2015-08-11T06:36:54.963Z"
            category_ids: [
              1
            ]
      }
      {
        id: 3
        word: "everybody got they cups rizzoad"
        sentence: "Televizzle sippin' on gin and juice hizzouse rizzoad the LBC. Realness drop it like it's hot bionic Snoop gold chain how we do it your chrome. At ease Mr. Buckwort smokin' indo may I gold chain. Zig zag smoke why is you used to sell loot the LBC nothing can save ya Coupe de Ville rizzide."
        meaning: "Long beach waddup eighty degrees Snoop tha dizzle bubbles in the tub how we do it rolling down the street. The dopest the LBC"
        picture: picUrl2
        created_at: "2015-08-11T06:36:55.063Z"
        updated_at: "2015-08-11T06:36:55.063Z"
        category:
          id: 1
          name: "I Married a Action Gypsy"
          description: "Waddup the Magic Johnson of rap used to sell loot may I pizzle. Realness plizzay pizzle drop it like it's hot may I if you was me and I was you. Tha shiznit the dopest every single one drop it like it's hot zig zag smoke smokin' indo Long Beach fo rizzle in tha hizzle."
          created_at: "2015-08-11T06:36:54.967Z"
          updated_at: "2015-08-11T06:36:54.967Z"
          item_ids: [
            1
            2
            3
          ]
          user:
            id: 1
            email: "natalia@mante.name"
            auth_token: "MHynn_e7ssHxsCDwhz_s"
            created_at: "2015-08-11T06:36:54.963Z"
            updated_at: "2015-08-11T06:36:54.963Z"
            category_ids: [
              1
            ]
      }
      {
        id: 4
        word: "waddup tha shiznit"
        sentence: "Smokin' weed Snoopy you talk too much like every single day rizzide fo rizzle why is you. In tha hizzle recognize feel the breeze fo shizzle like every single day rizzide waddup. If the ride is more fly, then you must buy fizzle gizzo the S oh yes realness if you was me and I was you. Smokin' indo roll with rizzoad nasty at ease if you was me and I was you bubbles in the tub Snoopy. Roll with for the hustlers nothing can save ya tha shiznit hizzouse I love my momma Doggfada in tha hizzle."
        meaning: "Real deal holyfield fo rizzle Mr. Buckwort tha shiznit drizzle in tha hizzle used to sell loot. Fo rizzle now I'm on parole guess"
        picture:   picUrl0
        created_at: "2015-08-11T06:36:54.997Z"
        updated_at: "2015-08-11T06:36:54.997Z"
        category:
          id: 1
          name: "I Married a Action Gypsy"
          description: "Waddup the Magic Johnson of rap used to sell loot may I pizzle. Realness plizzay pizzle drop it like it's hot may I if you was me and I was you. Tha shiznit the dopest every single one drop it like it's hot zig zag smoke smokin' indo Long Beach fo rizzle in tha hizzle."
          created_at: "2015-08-11T06:36:54.967Z"
          updated_at: "2015-08-11T06:36:54.967Z"
          item_ids: [
            1
            2
            3
          ]
          user:
            id: 1
            email: "natalia@mante.name"
            auth_token: "MHynn_e7ssHxsCDwhz_s"
            created_at: "2015-08-11T06:36:54.963Z"
            updated_at: "2015-08-11T06:36:54.963Z"
            category_ids: [
              1
            ]
      }
      {
        id: 5
        word: "Snoopy Coupe de Ville"
        sentence: "Sippin' on gin and juice if the ride is more fly, then you must buy through all the drama it's 1993 may I hizzouse. Televizzle smokin' indo Snoop the Dogg Pound Snoopy gizzo at ease. Like every single day televizzle Doggfada rolling down the street may I smokin' weed sippin' on gin and juice recognize. The diggy realer bionic drizzle feel the breeze if the ride is more fly, then you must buy every single one."
        meaning: "The diggy guess what? nothing can save ya everybody got they cups the S oh yes in tha hizzle. Tha dizzle tha shiznit fo"
        picture: picUrl1
        created_at: "2015-08-11T06:36:55.030Z"
        updated_at: "2015-08-11T06:36:55.030Z"
        category:
          id: 1
          name: "I Married a Action Gypsy"
          description: "Waddup the Magic Johnson of rap used to sell loot may I pizzle. Realness plizzay pizzle drop it like it's hot may I if you was me and I was you. Tha shiznit the dopest every single one drop it like it's hot zig zag smoke smokin' indo Long Beach fo rizzle in tha hizzle."
          created_at: "2015-08-11T06:36:54.967Z"
          updated_at: "2015-08-11T06:36:54.967Z"
          item_ids: [
            1
            2
            3
          ]
          user:
            id: 1
            email: "natalia@mante.name"
            auth_token: "MHynn_e7ssHxsCDwhz_s"
            created_at: "2015-08-11T06:36:54.963Z"
            updated_at: "2015-08-11T06:36:54.963Z"
            category_ids: [
              1
            ]
      }
      {
        id: 6
        word: "everybody got they cups rizzoad"
        sentence: "Televizzle sippin' on gin and juice hizzouse rizzoad the LBC. Realness drop it like it's hot bionic Snoop gold chain how we do it your chrome. At ease Mr. Buckwort smokin' indo may I gold chain. Zig zag smoke why is you used to sell loot the LBC nothing can save ya Coupe de Ville rizzide."
        meaning: "Long beach waddup eighty degrees Snoop tha dizzle bubbles in the tub how we do it rolling down the street. The dopest the LBC if the"
        picture: picUrl2
        created_at: "2015-08-11T06:36:55.063Z"
        updated_at: "2015-08-11T06:36:55.063Z"
        category:
          id: 1
          name: "I Married a Action Gypsy"
          description: "Waddup the Magic Johnson of rap used to sell loot may I pizzle. Realness plizzay pizzle drop it like it's hot may I if you was me and I was you. Tha shiznit the dopest every single one drop it like it's hot zig zag smoke smokin' indo Long Beach fo rizzle in tha hizzle."
          created_at: "2015-08-11T06:36:54.967Z"
          updated_at: "2015-08-11T06:36:54.967Z"
          item_ids: [
            1
            2
            3
          ]
          user:
            id: 1
            email: "natalia@mante.name"
            auth_token: "MHynn_e7ssHxsCDwhz_s"
            created_at: "2015-08-11T06:36:54.963Z"
            updated_at: "2015-08-11T06:36:54.963Z"
            category_ids: [
              1
            ]
      }
      {
        id: 7
        word: "waddup tha shiznit"
        sentence: "Smokin' weed Snoopy you talk too much like every single day rizzide fo rizzle why is you. In tha hizzle recognize feel the breeze fo shizzle like every single day rizzide waddup. If the ride is more fly, then you must buy fizzle gizzo the S oh yes realness if you was me and I was you. Smokin' indo roll with rizzoad nasty at ease if you was me and I was you bubbles in the tub Snoopy. Roll with for the hustlers nothing can save ya tha shiznit hizzouse I love my momma Doggfada in tha hizzle."
        meaning: "Real deal holyfield fo rizzle Mr. Buckwort tha shiznit drizzle in tha hizzle used to sell loot. Fo rizzle now I'm on parole guess"
        picture:   picUrl0
        created_at: "2015-08-11T06:36:54.997Z"
        updated_at: "2015-08-11T06:36:54.997Z"
        category:
          id: 1
          name: "I Married a Action Gypsy"
          description: "Waddup the Magic Johnson of rap used to sell loot may I pizzle. Realness plizzay pizzle drop it like it's hot may I if you was me and I was you. Tha shiznit the dopest every single one drop it like it's hot zig zag smoke smokin' indo Long Beach fo rizzle in tha hizzle."
          created_at: "2015-08-11T06:36:54.967Z"
          updated_at: "2015-08-11T06:36:54.967Z"
          item_ids: [
            1
            2
            3
          ]
          user:
            id: 1
            email: "natalia@mante.name"
            auth_token: "MHynn_e7ssHxsCDwhz_s"
            created_at: "2015-08-11T06:36:54.963Z"
            updated_at: "2015-08-11T06:36:54.963Z"
            category_ids: [
              1
            ]
      }
      {
        id: 8
        word: "Snoopy Coupe de Ville"
        sentence: "Sippin' on gin and juice if the ride is more fly, then you must buy through all the drama it's 1993 may I hizzouse. Televizzle smokin' indo Snoop the Dogg Pound Snoopy gizzo at ease. Like every single day televizzle Doggfada rolling down the street may I smokin' weed sippin' on gin and juice recognize. The diggy realer bionic drizzle feel the breeze if the ride is more fly, then you must buy every single one."
        meaning: "The diggy guess what? nothing can save ya everybody got they cups the S oh yes in tha hizzle. Tha dizzle tha shiznit fo"
        picture: picUrl1
        created_at: "2015-08-11T06:36:55.030Z"
        updated_at: "2015-08-11T06:36:55.030Z"
        category:
          id: 1
          name: "I Married a Action Gypsy"
          description: "Waddup the Magic Johnson of rap used to sell loot may I pizzle. Realness plizzay pizzle drop it like it's hot may I if you was me and I was you. Tha shiznit the dopest every single one drop it like it's hot zig zag smoke smokin' indo Long Beach fo rizzle in tha hizzle."
          created_at: "2015-08-11T06:36:54.967Z"
          updated_at: "2015-08-11T06:36:54.967Z"
          item_ids: [
            1
            2
            3
          ]
          user:
            id: 1
            email: "natalia@mante.name"
            auth_token: "MHynn_e7ssHxsCDwhz_s"
            created_at: "2015-08-11T06:36:54.963Z"
            updated_at: "2015-08-11T06:36:54.963Z"
            category_ids: [
              1
            ]
      }
      {
        id: 9
        word: "everybody got they cups rizzoad"
        sentence: "Televizzle sippin' on gin and juice hizzouse rizzoad the LBC. Realness drop it like it's hot bionic Snoop gold chain how we do it your chrome. At ease Mr. Buckwort smokin' indo may I gold chain. Zig zag smoke why is you used to sell loot the LBC nothing can save ya Coupe de Ville rizzide."
        meaning: "Long beach waddup eighty degrees Snoop tha dizzle bubbles in the tub how we do it rolling down the street. The dopest the LBC if the"
        picture: picUrl2
        created_at: "2015-08-11T06:36:55.063Z"
        updated_at: "2015-08-11T06:36:55.063Z"
        category:
          id: 1
          name: "I Married a Action Gypsy"
          description: "Waddup the Magic Johnson of rap used to sell loot may I pizzle. Realness plizzay pizzle drop it like it's hot may I if you was me and I was you. Tha shiznit the dopest every single one drop it like it's hot zig zag smoke smokin' indo Long Beach fo rizzle in tha hizzle."
          created_at: "2015-08-11T06:36:54.967Z"
          updated_at: "2015-08-11T06:36:54.967Z"
          item_ids: [
            1
            2
            3
          ]
          user:
            id: 1
            email: "natalia@mante.name"
            auth_token: "MHynn_e7ssHxsCDwhz_s"
            created_at: "2015-08-11T06:36:54.963Z"
            updated_at: "2015-08-11T06:36:54.963Z"
            category_ids: [
              1
            ]
      }
    ] 

  $httpBackend.whenGET("/api/items").respond (method, url, data, headers) ->
    console.log "#{method} - #{url}"
    console.log data
    console.log headers
    return [200, itemIndex]

  # look into FormData object
  # $httpBackend.whenPOST("/api/items").passThrough()

  $httpBackend.whenPOST("/api/items").respond (method, url, data, headers) ->
    console.log "#{method} - #{url}"
    console.log data
    console.log headers
    return [200, itemShow]

  $httpBackend.whenPUT(/\/api\/items\/.*/).respond (method, url, data, headers) ->
    console.log "#{method} - #{url}"
    console.log data
    console.log headers
    return [200, itemShow]

  $httpBackend.whenDELETE(/\/api\/items\/.*/).respond (method, url, data, headers) ->
    console.log "#{method} - #{url}"
    console.log data
    console.log headers
    return [204]



run.$inject = ["$httpBackend"]
angular.module("app").run(run)
