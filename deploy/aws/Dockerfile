FROM python

# https://docs.aws.amazon.com/eks/latest/userguide/configure-kubectl.html

# Install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
	&& mv kubectl /usr/local/bin \
	&& chmod +x /usr/local/bin/kubectl

# Install heptio-authenticator-aws
RUN curl -o heptio-authenticator-aws https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-06-05/bin/linux/amd64/heptio-authenticator-aws \
    && mv heptio-authenticator-aws /usr/local/bin \
	&& chmod +x /usr/local/bin/heptio-authenticator-aws

# Install aws-cli
RUN pip install awscli