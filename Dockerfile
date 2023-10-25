FROM bitnami/kubectl:1.20.9 as kubectl

FROM quay.io/operator-framework/ansible-operator:v1.25.1

COPY requirements.yml ${HOME}/requirements.yml
RUN ansible-galaxy collection install -r ${HOME}/requirements.yml \
 && chmod -R ug+rwx ${HOME}/.ansible

COPY --from=kubectl /opt/bitnami/kubectl/bin/kubectl /usr/local/bin/

COPY watches.yaml ${HOME}/watches.yaml
COPY roles/ ${HOME}/roles/
COPY playbooks/ ${HOME}/playbooks/
