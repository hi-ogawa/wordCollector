describe 'app', ->

  it "should redirect to /login", ->
    browser.get "index.html"
    expect(browser.getLocationAbsUrl()).toMatch "/login"
