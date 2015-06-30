# export data
data = YAML.dump(Post.all.map{|p| {w: p.word, s: p.sentence, p: p.picture, c: p.category_id}})
File.open('dbdata.yaml', 'w') {|f| f.write(data)}

# transfer data
`scp dbdata.yaml sakura:~/tests/wordCollector/wordCollectorRails`

# import data
data = File.open('dbdata.yaml').read
YAML.load(data).each{|ph| Post.create({word: ph[:w], sentence: ph[:s], picture: ph[:p], category_id: ph[:c]}) }
