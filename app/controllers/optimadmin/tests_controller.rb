module Optimadmin
  class TestsController < Optimadmin::ApplicationController
    before_action :set_test, only: [:show, :edit, :update, :destroy]

    def index
      @tests = Test.all
    end

    def show
    end

    def new
      @test = Test.new
    end

    def edit
    end

    def create
      @test = Test.new(test_params)
      if @test.save
        redirect_to @test, notice: 'Test was successfully created.'
      else
        render :new
      end
    end

    def update
      if @test.update(test_params)
        redirect_to @test, notice: 'Test was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @test.destroy
      redirect_to tests_url, notice: 'Test was successfully destroyed.'
    end

  private


    def set_test
      @test = @test.find(params[:id])
    end

    def test_params
      params.require(:test).permit(:name)
    end
  end
end