describe 'Cadastrar' do
    
    def login(field_email, field_password)
        @body = {
            session: {
                email: field_email,
                password: field_password
            }
        }.to_json
        @login = Login.post('/sessions', body: @body)
    end

    context 'tarefas' do
        before {login('brunobatista66@gmail.com', '123456')}
        
        it 'com sucesso' do
            @header = {
                Accept: 'application/vnd.tasksmanagers.v2',
                'Content-Type': 'application/json',
                Authorization: @login.parsed_response['data']['attributes']['auth-token']
            }

            @body = {
                task: {
                    title: 'Tarefa teste 2',
                    description: 'Descrição da tarefa',
                    deadline: '2018-08-21 15:00:00',
                    done: true
                }
            }.to_json


            @tarefas = Cadastrar.post('/tasks', body: @body, headers: @header)
            puts @tarefas
            puts "response code: #{@tarefas.code}"
            @nome_tarefa = @tarefas.parsed_response['data']['attributes']['title']
            expect(@nome_tarefa).to eq 'Tarefa teste 2' 

        end
    end
end