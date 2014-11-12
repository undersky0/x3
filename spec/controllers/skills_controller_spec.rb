require 'rails_helper'

RSpec.describe SkillsController, :type => :controller do
   
  describe 'GET #index' do
     context 'with params[:id]' do
     it "populates an array of skills from with skill_type(:id)" do
       
         skill1 = create(:skill, name: 'skill1', skill_type_id: '1')
         skill2 = create(:skill, name: 'skill2', skill_type_id: '2')
         get :index, id: 2
         expect(assigns(:skills)).to match_array([skill2])
     end
     it "renders the :index template" do
       get :index
       expect(response).to render_template :index
     end
     
   end
   
   context 'without params[:id]' do
     it "populates an array of skills with all skills"
     it "renders the :index template"
   end
end

    describe 'GET #show' do
      it "assigns the requested skill to @skill" do
        skill = create(:skill, name: 'test')
        get :show, id: skill
        expect(assigns(:skill)).to eq skill #skill = @skill
      end
      it "renders the :show template" do
        skill = create(:skill)
        get :show, id: skill
        expect(response).to render_template :show #render :show
      end
    end
    
    describe 'GET #new' do
       it "assigns a new Skill to @skill"
       it "renders the :new template"
    end
    
    describe 'GET #edit' do
       it "assigns the requested Skill to @skill"
       it "renders the :edit template"
    end
    
     describe "POST #create" do
        context "with valid attributes" do
          it "saves the new Skill in the database"
          it "redirects to skill#show"
        end
        context "with invalid attributes" do
          it "does not save the new skill in the database"
          it "re-renders the :new template"
       end
      end
      
      
    describe 'PATCH #update' do
       context "with valid attributes" do
        it "updates the skill in the database"
        it "redirects to the skill"
       end
       context "with invalid attributes" do
        it "does not update the skill"
        it "re-renders the #edit template"
       end
    end

    describe 'DELETE #destroy' do
        it "deletes the skill from the database"
        it "redirects to users#index"
      end
    end