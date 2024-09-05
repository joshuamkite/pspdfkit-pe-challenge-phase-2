# Start a new stage from scratch
FROM scratch

# Copy the binary into the image
COPY ./bin/pspdfkit_pe_challenge_linux_amd64 /usr/local/bin/pspdfkit_pe_challenge

# Expose the port the app runs on
EXPOSE 8080

# Add a label for the image description
LABEL org.opencontainers.image.description="PSPDFKit PE Candidate Challenge"

# Run the Go binary
ENTRYPOINT ["/usr/local/bin/pspdfkit_pe_challenge"]
