module.exports = {
    moduleFileExtensions: ['js', 'json', 'ts'],
    rootDir: '.',
    testRegex: '.*\\.spec\\.ts$',
    transform: {
        '^.+\\.(t|j)s$': 'ts-jest',
    },
    collectCoverageFrom: [
        //'**/*.(t|j)s',
        '**/domain/models/**',
    ],
    coverageDirectory: './coverage',
    coverageReporters: ['lcov', 'text', 'json'],
    testEnvironment: 'node',
    moduleDirectories: ['node_modules', '<rootDir>'],
};
