const { setGlobalOptions } = require("firebase-functions");
const { onCall, HttpsError } = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");
const nodemailer = require("nodemailer");

setGlobalOptions({ maxInstances: 10 });

// Gmail
const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: "carabants20061@gmail.com",
    pass: process.env.GMAIL_APP_PASSWORD,
  },
});

exports.sendOtp = onCall(async (request) => {
  const { email, otp } = request.data;

  if (!email || !otp) {
    throw new HttpsError(
      "invalid-argument",
      "Email and OTP are required."
    );
  }

  try {
    await transporter.sendMail({
      from: "carabants20061@gmail.com",
      to: email,
      subject: "Tech Store Verification Code",
      html: `
        <div style="font-family: Arial; padding: 20px;">
          <h2>Tech Store</h2>
          <p>Your verification code is:</p>
          <h1 style="letter-spacing: 8px;">${otp}</h1>
          <p>This code is valid for a limited time.</p>
        </div>
      `,
    });

    logger.info(`OTP sent to ${email}`);

    return {
      success: true,
      message: "OTP sent successfully.",
    };
  } catch (error) {
    logger.error("Failed to send OTP", error);

    throw new HttpsError(
      "internal",
      "Failed to send OTP."
    );
  }
});