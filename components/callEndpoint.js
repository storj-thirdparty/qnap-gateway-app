import axios from 'axios';

export default async (apiRequest, args = {}) => {
	const input = {
		apiRequest,
		...args
	};

	return {data} = await axios.post('interface.php', input);

	if(typeof data.error === 'string') {
		throw new Error(data.error);
	}

	return data;
};
