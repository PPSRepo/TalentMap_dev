<?php
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require '../resources/PHPMailer/src/Exception.php';
require '../resources/PHPMailer/src/PHPMailer.php';
require '../resources/PHPMailer/src/SMTP.php';

class mailerController
{

    // TODO - Insert your code here
    public function __construct()
    {
        
        // TODO - Insert your code here
    }
    
    public function sendMail($recp,$mailTemplate)
    {
        $mail = new PHPMailer(); // create a new object
        $mail->IsSMTP(); // enable SMTP
       // $mail->SMTPDebug = 2; // debugging: 1 = errors and messages, 2 = messages only
        $mail->SMTPAuth = true; // authentication enabled
        $mail->SMTPSecure = 'tls'; // secure transfer enabled REQUIRED for Gmail
        //$mail->Host = gethostbyname('smtp.gmail.com');
        //$mail->Host = "smtp.gmail.com";
        $mail->Port = 587; // or 587 465
        
        
        $mail->SMTPOptions = array(
            'ssl' => array(
                'verify_peer' => false,
                'verify_peer_name' => false,
                'allow_self_signed' => true
            )
        );
        $mail->IsHTML(true);
        $mail->SMTPAutoTLS = false;
        $mail->Host = gethostbyname('smtp.gmail.com');
        $mail->Username = "talentmap.csolutions@gmail.com";
        $mail->Password = "CapSt0ne2018#";
        
        $mail->SetFrom("talentmap.csolutions@gmail.com","TalentMap System");
        $mail->AddReplyTo('Talentmap@csolutions.org', 'TalentMap team');
        /*$mail->Host = 'tls://smtp.gmail.com:587';
        $mail->Username = "pps.cad2018@gmail.com";
        $mail->Password = "pps12345";
        
        $mail->SetFrom("pps.cad2018@gmail.com","Talent Map");
        */   
        $mail->Subject = $mailTemplate["subject"];
        $mail->Body = $mailTemplate["body"];
        $mail->AddAddress($recp);
      //  echo (extension_loaded('openssl')?'SSL loaded':'SSL not loaded')."\n";
        $res = array();
        if(!$mail->Send()) {
            $res["status"] = 400;
            $res["error"] = "Mailer Error: " . $mail->ErrorInfo;
            //echo "Mailer Error: " . $mail->ErrorInfo;
        } else {
            $res["status"] = 200;
            $res["message"] = "Message has been sent";
        }
        return $res;
    }
}

