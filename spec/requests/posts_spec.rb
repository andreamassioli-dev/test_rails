require 'rails_helper'

RSpec.describe 'Post' do

  describe 'GET /api/posts' do
    it 'lists posts' do
      post = Post.create!(title: 'Foo', tags: [Tag.new(name: 'bar')])

      get api_posts_path(format: 'json')
      expect(response).to be_successful

      json = JSON.parse(response.body)
      expect(json).to be_a(Array)
      expect(json[0]['title']).to eq(post.title)
      expect(json[0]['tags'].count).to eq(post.tags.count)
      expect(json[0]['tags'].first['name']).to eq(post.tags.first.name)
    end
  end

  describe 'GET /api/search' do
    it 'searches term in posts and tags' do
      get api_posts_search_path(format: 'json')
      expect(response).to be_successful
      json = JSON.parse(response.body)
      expect(json).to match_array([])

      get api_posts_search_path(format: 'json', params: { term: "" })
      expect(response).to be_successful
      json = JSON.parse(response.body)
      expect(json).to match_array([])

      Post.create!(title: 'Findme', tags: [Tag.new(name: 'Notme')])
      Post.create!(title: 'Notme', tags: [Tag.new(name: 'Findme')])
      Post.create!(title: 'Findme', tags: [Tag.new(name: 'Findme')])
      Post.create!(title: 'Notme', tags: [Tag.new(name: 'Notme')])
      Post.create!(title: '_Findme_', tags: [Tag.new(name: 'Notme')])
      Post.create!(title: 'Notme', tags: [Tag.new(name: '_Findme_')])
      get api_posts_search_path(format: 'json', params: { term: "findme" })
      expect(response).to be_successful
      json = JSON.parse(response.body)
      expect(json).to be_a(Array)
      expect(json.length).to eq(5)
    end
  end
end
