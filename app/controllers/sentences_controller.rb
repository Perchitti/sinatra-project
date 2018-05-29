class SentencesController < ApplicationController

  get '/sentences' do
    if logged_in?
      @sentences = Sentence.all
      erb :'sentences/sentences'
    else
      redirect 'login'
    end
  end

  get '/sentences/new' do
    if logged_in?
      erb :'sentences/create_sentence'
    else
      redirect 'login'
    end
  end

  post '/sentences' do
    if logged_in?
      if params[:content] == ''
        redirect 'sentences/new'
      else
        @sentence = current_user.sentences.build(content: params[:content])
        if @sentence.save
          redirect "/sentences/#{@sentence.id}"
        else
          redirect 'sentences/new'
        end
      end
      redirect '/login'
    end
  end

  get '/sentences/:id' do
    if logged_in?
      @sentence = Sentence.find_by_id(params[:id])
      erb :'sentences/show_sentence'
    else
      redirect '/login'
    end
  end

  get '/sentences/:id/edit' do
    if logged_in?
      @sentence = Sentence.find_by_id(params[:id])
      if @sentence && @sentence.user == current_user
        erb :'sentences/edit_sentence'
      else
        redirect '/sentences'
      end
    else
      redirect '/login'
    end
  end

  patch '/sentences/:id' do
    if logged_in?
      if params[:content] == ""
        redirect to "/sentences/#{params[:id]}/edit"
      else
        @sentence = Sentence.find_by_id(params[:id])
        if @sentence && @sentence.user == current_user
          if @sentence.update(content: params[:content])
            redirect to "/sentences/#{@sentence.id}"
          else
            redirect "/sentences/#{@sentence.id}/edit"
          end
        else
          redirect '/sentences'
        end
      end
    else
      redirect '/login'
    end
  end

delete '/sentences/:id/delete' do
  if logged_in?
    @sentence = Sentence.find_by_id(params[:id])
    if @sentence && @sentence.user == current_user
      @sentence.delete
      redirect "/sentences"
    else
      redirect "/login"
    end
  end
end

end
