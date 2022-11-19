module Api
	module V1
		class ArticlesController < ApplicationController
			# Listar todos os artigos (index0)
			def index
				articles = Article.order('created_at DESC');
				render json: {status: 'SUCCESS', message:'Os artigos foram carregados com sucesso.', data:articles}, status: :ok
			end
			# Listar artigo passando ID
			def show
				article = Article.find(params[:id])
				render json: {status: 'SUCCESS', message:'O artigo foi carregado com sucesso.', data:article}, status: :ok
			end
			# Criar um novo artigo (create)
			def create
				article = Article.new(article_params)
				if article.save
					render json: {status: 'SUCCESS', message:'O artigo criado foi salvo com sucesso.', data:article}, status: :ok
				else
					render json: {status: 'ERROR', message:'Ops! Ocorreu um erro ao processar o artigo.', data:article.erros}, status: :unprocessable_entity
				end
			end
			# Excluir artigo - destroy / delete
			def destroy
				article = Article.find(params[:id])
				article.destroy
				render json: {status: 'SUCCESS', message:'O artigo foi removido com sucesso.', data:article}, status: :ok
			end
			# Atualizar um artigo - update/patch
			def update
				article = Article.find(params[:id])
				if article.update_attribute(article_params)
					render json: {status: 'SUCCESS', message:'O artigo editado foi atualizado com sucesso.', data:article}, status: :ok
				else
					render json: {status: 'ERROR', message:'Ops! Ocorreu um erro ao atualizar o artigo.', data:article.erros}, status: :unprocessable_entity
				end
			end
			# Parametros aceitos - criando validações para nossa controller relacioandas aos artigos
			private
			def article_params
				params.permit(:title, :body)
			end
		end
	end
end
