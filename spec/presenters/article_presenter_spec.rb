require 'rails_helper'

RSpec.describe ArticlePresenter, type: :presenter do
  let(:article) { create(:article) }
  subject(:article_presenter) { ArticlePresenter.new(object: article, view_template: view) }

  describe "standard article accessing model attributes" do
    it "returns the article id" do
      expect(article_presenter.id).to eq(article.id)
    end

    it "returns downcased article class_name" do
      expect(article_presenter.class_name).to eq(article.class.name.downcase)
    end

    it "returns article title" do
      expect(article_presenter.title).to eq(article.title)
    end
  end

  context "article without image" do
    it "links title without options" do
      link = link_to article.title, article
      expect(article_presenter.linked_title).to eq(link)
    end

    it "links title with options" do
      link = link_to article.title, article, class: "my-class"
      expect(article_presenter.linked_title(class: "my-class")).to eq(link)
    end

    it "formats date to long by default" do
      date = view.content_tag :span, class: 'date' do
        l article.date, format: :long
      end
      expect(article_presenter.date).to eq(date)
    end

    it "format date to set format" do
      date = view.content_tag :span, class: 'date' do
        l article.date, format: :short
      end
      expect(article_presenter.date(:short)).to eq(date)
    end

    it "correctly escapes html on summary" do
      summary = raw(article.summary)
      expect(article_presenter.summary).to eq(summary)
    end

    it "correctly escapes html on content" do
      content = raw(article.content)
      expect(article_presenter.content).to eq(content)
    end

    it "returns nil when image method called" do
      expect(article_presenter.image).to be nil
    end

    it "return default home image" do
      # need to use view. here - see https://github.com/rails/rails/issues/7218
      linked_image = link_to view.image_tag('placeholders/home-slider.jpg', alt: article.title), article, title: article.title
      expect(article_presenter.linked_home_image).to eq(linked_image)
    end
  end

  describe "article with an image" do
    let(:article) { create(:article_with_image) }
    subject(:article_presenter) { ArticlePresenter.new(object: article, view_template: view) }

    it "returns image when image method called" do
      image = image_tag(article.image.show, alt: article.title, class: 'page-image image-right')
      expect(article_presenter.image).to eq(image)
    end

    it "returns home image" do
      linked_image = link_to image_tag(article.image.homepage, alt: article.title), article, title: article.title
      expect(article_presenter.linked_home_image).to eq(linked_image)
    end
  end
end