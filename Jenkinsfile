pipeline {
    agent any

    options {
        disableConcurrentBuilds()
        timestamps()
    }

    stages {
        stage('Delete existing job') {
            steps {
                sh '''
                    PATH=$PATH:~/helpers
                    if kubectl get jobs | grep 'se-variants-machine-learning'; then kubectl delete job se-variants-machine-learning; fi
                    kubectl get jobs
                '''
            }
        }
        stage("Create job template") {
            steps {
                sh '''
                    cat <<EOF > se-variants-machine-learning.yml
                    apiVersion: batch/v1
                    kind: Job
                    metadata:
                      name: se-variants-machine-learning
                      namespace: epam
                    spec:
                      ttlSecondsAfterFinished: 20
                      template:
                        metadata:
                          labels:
                            job-name: se-variants-machine-learning
                        spec:
                          containers:
                          - args: ['--creds', '/opt/creds.json', '--ranges', "${RANGE_ID}"]
                            command: ["python3", "/se_pv/main_pipeline_script.py"] 
                            image: ${IMAGE_ID}
                            imagePullPolicy: Always
                            name: se-variants-machine-learning
                            resources:
                              requests:
                                memory: "2048Mi"
                                cpu: "1000m"
                              limits:
                                memory: "8192Mi"
                                cpu: "2000m"
                            securityContext:
                              allowPrivilegeEscalation: false
                              capabilities: {}
                              privileged: false
                              readOnlyRootFilesystem: false
                              runAsNonRoot: false
                            volumeMounts:
                            - mountPath: /opt
                              name: se-variants-ml-creds
                          volumes:
                          - configMap:
                              defaultMode: 493
                              name: se-ml-config
                              optional: false
                            name: se-variants-ml-creds
                          imagePullSecrets:
                          - name: se
                          restartPolicy: Never
                    EOF
                '''.stripIndent()
            }
        }
        stage("Run job") {
            steps {
                sh '''
                    cat se-variants-machine-learning.yml
                '''
            }
        }
    }
}
