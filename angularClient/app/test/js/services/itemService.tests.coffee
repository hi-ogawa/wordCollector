describe "ItemService", ->

  createArg =
    word:     "fizzle Long Beach"
    sentence: "The s oh yes with my mind on my money every single one gold chain plizzay for the Gs feel the breeze the Magic Johnson of rap. Real deal holyfield tha shiznit the Magic Johnson of rap make a few ends the diggy the S oh yes if the ride is more fly, then you must buy. The lbc gold chain Mr. Buckwort zig zag smoke waddup in tha hizzle Long Beach Coupe de Ville. Smokin' indo smokin' weed gold chain if you was me and I was you used to sell loot put ya choppers up. Put ya choppers up rizzoad it's 1993 every single one rizzide."
    meaning:  "Doggfada and my money on my mind if the ride is more fly, then you must buy rolling down the street for the Gs make a few ends. Plizzay for the Gs make a few ends bionic nothing can save ya if you was me and I was you. For the hustlers if the ride is more fly, then you must buy rizzide your chrome bubbles in the tub. Waddup used to sell loot Doggfada rizzide drizzle like every single day. Realer guess what? the diggy you talk too much the dopest used to sell loot your chrome eighty degrees."
    picture: "?????????????"
    category:
      id: 1

  updateArg = destroyArg =
    id: 1
    word: "fizzle Long Beach"
    sentence: "The s oh yes with my mind on my money every single one gold chain plizzay for the Gs feel the breeze the Magic Johnson of rap. Real deal holyfield tha shiznit the Magic Johnson of rap make a few ends the diggy the S oh yes if the ride is more fly, then you must buy. The lbc gold chain Mr. Buckwort zig zag smoke waddup in tha hizzle Long Beach Coupe de Ville. Smokin' indo smokin' weed gold chain if you was me and I was you used to sell loot put ya choppers up. Put ya choppers up rizzoad it's 1993 every single one rizzide."
    meaning: "Doggfada and my money on my mind if the ride is more fly, then you must buy rolling down the street for the Gs make a few ends. Plizzay for the Gs make a few ends bionic nothing can save ya if you was me and I was you. For the hustlers if the ride is more fly, then you must buy rizzide your chrome bubbles in the tub. Waddup used to sell loot Doggfada rizzide drizzle like every single day. Realer guess what? the diggy you talk too much the dopest used to sell loot your chrome eighty degrees."
    picture: "/system/items/pictures/000/000/001/original/test.png?1439275015"
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

  createPayload = updatePayload =
    category_id: 1
    item: _(createArg).pick ["word", "sentence", "meaning", "picture"]

  createResponse = updateResponse =
    item:
      id: 1
      word: "fizzle Long Beach"
      sentence: "The s oh yes with my mind on my money every single one gold chain plizzay for the Gs feel the breeze the Magic Johnson of rap. Real deal holyfield tha shiznit the Magic Johnson of rap make a few ends the diggy the S oh yes if the ride is more fly, then you must buy. The lbc gold chain Mr. Buckwort zig zag smoke waddup in tha hizzle Long Beach Coupe de Ville. Smokin' indo smokin' weed gold chain if you was me and I was you used to sell loot put ya choppers up. Put ya choppers up rizzoad it's 1993 every single one rizzide."
      meaning: "Doggfada and my money on my mind if the ride is more fly, then you must buy rolling down the street for the Gs make a few ends. Plizzay for the Gs make a few ends bionic nothing can save ya if you was me and I was you. For the hustlers if the ride is more fly, then you must buy rizzide your chrome bubbles in the tub. Waddup used to sell loot Doggfada rizzide drizzle like every single day. Realer guess what? the diggy you talk too much the dopest used to sell loot your chrome eighty degrees."
      picture: "/system/items/pictures/000/000/001/original/test.png?1439275015"
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

  indexResponse =
    items: [
      {
        id: 1
        word: "waddup tha shiznit"
        sentence: "Smokin' weed Snoopy you talk too much like every single day rizzide fo rizzle why is you. In tha hizzle recognize feel the breeze fo shizzle like every single day rizzide waddup. If the ride is more fly, then you must buy fizzle gizzo the S oh yes realness if you was me and I was you. Smokin' indo roll with rizzoad nasty at ease if you was me and I was you bubbles in the tub Snoopy. Roll with for the hustlers nothing can save ya tha shiznit hizzouse I love my momma Doggfada in tha hizzle."
        meaning: "Real deal holyfield fo rizzle Mr. Buckwort tha shiznit drizzle in tha hizzle used to sell loot. Fo rizzle now I'm on parole guess what? your chrome it's 1993 and my money on my mind every single one realer. Make a few ends smokin' weed for the hustlers real deal Holyfield like every single day."
        picture: "/system/items/pictures/000/000/001/original/test.png?1439275014"
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
        meaning: "The diggy guess what? nothing can save ya everybody got they cups the S oh yes in tha hizzle. Tha dizzle tha shiznit fo rizzle drop it like it's hot rizzoad guess what?. For the gs the Magic Johnson of rap drop it like it's hot every single one Long Beach in tha hizzle plizzay. Through all the drama at ease for the Gs zig zag smoke every single one feel the breeze eighty degrees guess what? bubbles in the tub."
        picture: "/system/items/pictures/000/000/002/original/test.png?1439275015"
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
        meaning: "Long beach waddup eighty degrees Snoop tha dizzle bubbles in the tub how we do it rolling down the street. The dopest the LBC if the ride is more fly, then you must buy how we do it every single one make a few ends drop it like it's hot. Make a few ends laid back guess what? for the hustlers rizzide with my mind on my money your chrome. May i sippin' on gin and juice bubbles in the tub through all the drama how we do it now I'm on parole smokin' weed hizzouse laid back. Realness recognize Snoopy every single one how we do it hizzouse the LBC."
        picture: "/system/items/pictures/000/000/003/original/test.png?1439275015"
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

  ItemService = AuthService = $httpBackend = null
  beforeEach module "app"
  beforeEach module ($provide) ->
    AuthService =
      getSession: ->
        userId: 1
        token:  "sP3hoKN5-y-tRtagTf2B"
    $provide.value "AuthService", AuthService
    return
  
  beforeEach inject (_ItemService_, _$httpBackend_) ->
    [ItemService, $httpBackend] =
      [_ItemService_, _$httpBackend_]

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()

  describe ".index", ->
    it "", ->
      $httpBackend.expectGET("/api/items").respond(indexResponse)
      ItemService.index()
      $httpBackend.flush()

  describe ".create", ->
    it "", ->
      $httpBackend.expectPOST("/api/items", createPayload, (headers) ->
        headers["Authorization"] is "sP3hoKN5-y-tRtagTf2B"
      ).respond(createResponse)
      ItemService.create(createArg)
      $httpBackend.flush()

  describe ".update", ->
    it "", ->
      $httpBackend.expectPUT("/api/items/1", updatePayload, (headers) ->
        headers["Authorization"] is "sP3hoKN5-y-tRtagTf2B"
      ).respond(updateResponse)
      ItemService.update(updateArg)
      $httpBackend.flush()

  describe ".delete", ->
    it "", ->
      $httpBackend.expectDELETE("/api/items/1", undefined, (headers) ->
        headers["Authorization"] is "sP3hoKN5-y-tRtagTf2B"
      ).respond(-> [204])
      ItemService.destroy(destroyArg)
      $httpBackend.flush()
