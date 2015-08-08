RSpec.configure do |c|
  c.alias_it_should_behave_like_to :it_has, ''
end

shared_examples "http status" do |code|
  it {expect(subject.status).to eql code}
end

# ex.
# subject {response}
# it_has "http status", 200
# =>
# http status
#   should eql 200
