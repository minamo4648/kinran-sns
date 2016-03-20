class InvitationsController < ApplicationController
    
    def edit
        @invitation = Invitation.find(params[:id])
    end

    def update
      
        @invitation = Invitation.find(params[:id])
        
        if @invitation.update(invitation_params)
          redirect_to invite_path, notice: "編集が完了しました"
        else
          redirect_to edit_invitation_path
        end
    
    end
    
    def mysend

        @users = User.where(mail_to: true)
        @invitaiton = Invitation.find(params[:id])
        @tankas = Tanka.where('submitted_at > ?' , 1.month.ago).order(kin_cnt: :desc, ransho_cnt: :desc, submitted_at: :asc).limit(10)

        @users.each do |user|
      
          @tanka = @tankas.limit(1).offset(Random.rand(1 .. @tankas.count)-1).take
      
          UserMailer.invitation(@invitaiton.body,user.name,user.email,@invitaiton.subject,@tanka).deliver_now
          
          user.update(last_mail: Time.zone.now)

        end
     
        @users.update_all(mail_to: false)
     
        redirect_to invite_path, notice: '送信しました' 
    end

  private

    def invitation_params
      params.require(:invitation).permit(:body, :subject)
    end
    
end
