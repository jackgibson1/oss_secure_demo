# Use an official Python runtime as a parent image
FROM docker.cloudsmith.io/demo/ciara-test/python:3.8-slim

# Set the working directory in the container
WORKDIR /flask_app

# Copy the current directory contents into the container at /flask_app
COPY flask_app/app.py /flask_app
COPY flask_app/requirements.txt /flask_app

# Create the .netrc file for authentication
ARG CLOUDSMITH_USERNAME
ARG CLOUDSMITH_API_KEY
RUN echo "machine dl.cloudsmith.io\nlogin ${CLOUDSMITH_USERNAME}\npassword ${CLOUDSMITH_API_KEY}" > ~/.netrc

# Set the PIP_INDEX_URL environment variable
ENV PIP_INDEX_URL=https://${CLOUDSMITH_USERNAME}:${CLOUDSMITH_API_KEY}@dl.cloudsmith.io/basic/demo/ciara-test/python/simple/

# Install any needed packages specified in requirements.txt using the Cloudsmith repository
RUN pip install --no-cache-dir -r requirements.txt

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Run app.py when the container launches
CMD ["python", "app.py"]
