interface DataBoxProps {
  heading: string;
  data: string;
  children: React.ReactNode;
}

const DataBox = (props: DataBoxProps) => {
  return (
    <div className="rounded-[10px] border-[2px] border-white/[0.15] bg-[#080608]/[0.4] p-[7px] backdrop-blur-[15px] backdrop-filter">
      <div className="flex flex-row space-x-[3px]">
        {props.children}
        <p className="text-[0.75rem] font-[600] text-[#5C5C5C]">
          {props.heading.toUpperCase()}
        </p>
      </div>
      <p className="text-[0.8rem] font-[600] text-[#C7C7C7]">
        {props.data.toUpperCase()}
      </p>
    </div>
  );
};

export default DataBox;
