# Use an official Python runtime as a parent image
FROM python:3.8-slim

# Set the working directory in the container
WORKDIR /flask_app

# Copy the current directory contents into the container at /app
COPY flask_app/app.py /flask_app
COPY flask_app/requirements.txt /flask_app

# Create the .pypirc file using build arguments for secrets
ARG CLOUDSMITH_USERNAME
ARG CLOUDSMITH_API_KEY
RUN echo "[distutils]\n\
index-servers =\n\
    cloudsmith\n\
[cloudsmith]\n\
repository: https://python.cloudsmith.io/demo/ciara-test/\n\
username: ${CLOUDSMITH_USERNAME}\n\
password: ${CLOUDSMITH_API_KEY}\n" > ~/.pypirc

# Install any needed packages specified in requirements.txt using the Cloudsmith repository
#RUN pip install --no-cache-dir -r requirements.txt --extra-index-url https://python.cloudsmith.io/demo/ciara-test/
#RUN pip install --no-cache-dir -r requirements.txt --index-url https://python.cloudsmith.io/demo/ciara-test/
RUN pip install --no-cache-dir -r requirements.txt --index-url https://dl.cloudsmith.io/public/demo/ciara-test/python/simple/



# Install any needed packages specified in requirements.txt
#RUN pip install --no-cache-dir -r requirements.txt

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Define environment variable
#ENV NAME World

# Run app.py when the container launches
CMD ["python", "app.py"]
