<?php
/**
 * Created by PhpStorm.
 * User: Taras
 * Date: 26.08.2020
 * Time: 16:14
 *
 * @author Taras Shkodenko <taras@shkodenko.com>
 */

require_once dirname(__FILE__) . '/../vendor/autoload.php';


use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;
use Symfony\Component\Yaml\Yaml;


$appConfig = Yaml::parseFile( dirname(__FILE__) . '/../config/app.yml');
// echo var_export($appConfig, true) . PHP_EOL;
if (!isset($appConfig['mail']) || !is_array($appConfig['mail']) || empty($appConfig['mail'])) {
    die('Error is in mail config!' . PHP_EOL);
}

$mail = new PHPMailer(true);

try {
    //Server settings
    $mail->SMTPDebug = SMTP::DEBUG_SERVER;                      // Enable verbose debug output
    $mail->isSMTP();                                            // Send using SMTP
    $mail->Host       = $appConfig['mail']['host'];             // Set the SMTP server to send through
    $mail->SMTPAuth   = true;                                   // Enable SMTP authentication
    $mail->Username   = $appConfig['mail']['user'];             // SMTP username
    $mail->Password   = $appConfig['mail']['passwd'];           // SMTP password
    $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;            // Enable TLS encryption; `PHPMailer::ENCRYPTION_SMTPS` encouraged
    $mail->Port       = $appConfig['mail']['port'];             // TCP port to connect to, use 465 for `PHPMailer::ENCRYPTION_SMTPS` above

    //Recipients
    if (is_array($appConfig['mail']['from']) && !empty($appConfig['mail']['from'])) {
        foreach ($appConfig['mail']['from'] as $mailAddr => $mailName) {
            $mail->setFrom($mailAddr, $mailName);
        }
    }
    $mail->addAddress('podlom@gmail.com', 'Taras Shkodenko');     // Add a recipient
    // $mail->addAddress('ellen@example.com');               // Name is optional
    // $mail->addReplyTo('info@example.com', 'Information');
    // $mail->addCC('cc@example.com');
    // $mail->addBCC('bcc@example.com');

    // Attachments
    // $mail->addAttachment('/var/tmp/file.tar.gz');         // Add attachments
    // $mail->addAttachment('/tmp/image.jpg', 'new.jpg');    // Optional name

    // Content
    $mail->isHTML(true);                                  // Set email format to HTML
    $mail->Subject = 'Here is the subject';
    $mail->Body    = 'This is the HTML message body <b>in bold!</b>';
    $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';

    $mail->send();
    echo 'Message has been sent';
} catch (Exception $e) {
    echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
}
