require "rails_helper"

describe Optimadmin::ArticlesController, type: :controller do
  routes { Optimadmin::Engine.routes }
  before(:each) do
    sign_in
  end

  describe "#create" do
    context "when article is valid" do
      it "redirects to index on normal save" do
        article = stub_valid_article

        post :create, commit: "Save", article: article.attributes

        expect(response).to redirect_to(articles_path)
        expect(flash[:notice]).to eq("Article was successfully created.")
      end

      it "redirects to edit on save and continue editing" do
        article = stub_valid_article

        post :create, commit: "Save and continue editing", article: article.attributes

        expect(response).to redirect_to(edit_article_path(article))
        expect(flash[:notice]).to eq("Article was successfully created.")
      end
    end

    context "when article is invalid" do
      it "renders the edit template" do
        article = stub_invalid_article

        post :create, commit: "Save", article: article.attributes

        expect(response).to render_template(:new)
      end
    end
  end

  describe "#update" do
    context "when article is valid" do
      it "redirects to index on normal save" do
        article = stub_valid_article

        patch :update, id: article.id, commit: "Save", article: article.attributes

        expect(response).to redirect_to(articles_path)
        expect(flash[:notice]).to eq("Article was successfully updated.")
      end

      it "redirects to edit on save and continue editing" do
        article = stub_valid_article

        patch :update, id: article.id, commit: "Save and continue editing", article: article.attributes

        expect(response).to redirect_to(edit_article_path(article))
        expect(flash[:notice]).to eq("Article was successfully updated.")
      end
    end

    context "when article is invalid" do
      it "renders the edit template" do
        article = stub_invalid_article

        patch :update, id: article.id, commit: "Save", article: article.attributes

        expect(response).to render_template(:edit)
      end
    end
  end
  def stub_valid_article
    article = build_stubbed(:article)
    allow(Article).to receive(:new).and_return(article)
    allow(article).to receive(:save).and_return(true)
    allow(Article).to receive(:find).and_return(article)
    allow(article).to receive(:update).and_return(true)
    article
  end

  def stub_invalid_article
    article = build_stubbed(:article)
    allow(Article).to receive(:new).and_return(article)
    allow(article).to receive(:save).and_return(false)
    allow(Article).to receive(:find).and_return(article)
    allow(article).to receive(:update).and_return(false)
    article
  end
end

