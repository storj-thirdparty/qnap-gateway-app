import axios from 'axios';

export default async (apiRequest, args = {}) => {
	return {};

	try {
		const input = {
			apiRequest,
			...args
		};

		const {data} = await axios.post('interface.php', input);

		if(typeof data.error === 'string') {
			alert(`backend error: ${data.error}`);
			throw new Error(data.error);
		}

		return data;
	} catch(error) {
		alert(`integration error: failed to connect to backend`);
	}
};
