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


run.$inject = ["$httpBackend"]
angular.module("app").run(run)
