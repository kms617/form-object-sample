Team.create(name: 'Android')
Team.create(name: 'Backend')
Team.create(name: 'Design')
Team.create(name: 'iOS')
Team.create(name: 'Proj. Mgmt.')
Team.create(name: 'Sales')
Team.create(name: 'Marketing')
Team.create(name: 'Product Management')
Team.create(name: 'Management')

HireType.create(contract_type: 'apprentice',
                name: 'Apprentice',
                work_status: 'no_visa')
HireType.create(contract_type: 'apprentice',
                name: 'International Apprentice',
                work_status: 'visa')
HireType.create(contract_type: 'full_time',
                name: 'International Full Time',
                work_status: 'visa')
HireType.create(contract_type: 'full_time',
                name: 'Full Time',
                work_status: 'no_visa')
