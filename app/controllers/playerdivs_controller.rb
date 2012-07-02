class PlayerdivsController < ApplicationController
  # GET /playerdivs
  # GET /playerdivs.json
  def index
    @playerdivs = Playerdiv.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @playerdivs }
    end
  end

  # GET /playerdivs/1
  # GET /playerdivs/1.json
  def show
    @playerdiv = Playerdiv.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @playerdiv }
    end
  end

  # GET /playerdivs/new
  # GET /playerdivs/new.json
  def new
    @playerdiv = Playerdiv.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @playerdiv }
    end
  end

  # GET /playerdivs/1/edit
  def edit
    @playerdiv = Playerdiv.find(params[:id])
  end

  # POST /playerdivs
  # POST /playerdivs.json
  def create
    @playerdiv = Playerdiv.new(params[:playerdiv])

    respond_to do |format|
      if @playerdiv.save
        format.html { redirect_to @playerdiv, :notice => 'Playerdiv was successfully created.' }
        format.json { render :json => @playerdiv, :status => :created, :location => @playerdiv }
      else
        format.html { render :action => "new" }
        format.json { render :json => @playerdiv.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /playerdivs/1
  # PUT /playerdivs/1.json
  def update
    @playerdiv = Playerdiv.find(params[:id])

    respond_to do |format|
      if @playerdiv.update_attributes(params[:playerdiv])
        format.html { redirect_to @playerdiv, :notice => 'Playerdiv was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @playerdiv.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /playerdivs/1
  # DELETE /playerdivs/1.json
  def destroy
    @playerdiv = Playerdiv.find(params[:id])
    @playerdiv.destroy

    respond_to do |format|
      format.html { redirect_to playerdivs_url }
      format.json { head :no_content }
    end
  end
end
